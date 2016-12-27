module Spree
  module Search
    class KomiComixSearch < Spree::Core::Search::Base
      attr_accessor :properties
      attr_accessor :current_user
      attr_accessor :current_currency

      def initialize(params)
        self.current_currency = Spree::Config[:currency]
        @properties = {}
        prepare(params)
      end

      def retrieve_products
        @products = get_base_scope
        curr_page = page || 1

        unless Spree::Config.show_products_without_price
          @products = @products.where("spree_prices.amount IS NOT NULL").
                                where("spree_prices.currency" => current_currency)
        end
        @products = @products.page(curr_page).per(per_page)
      end

      def method_missing(name)
        if @properties.has_key? name
          @properties[name]
        else
          super
        end
      end

      protected
        def get_base_scope
          base_scope = Spree::Product.active
          base_scope = base_scope.in_taxon(taxons) unless taxon.blank?
          #base_scope = base_scope.in_taxons(taxons) unless taxons.nil?
          base_scope = custom_filter_by_taxons(taxons, base_scope) unless taxons.nil?
          base_scope = get_products_conditions_for(base_scope, keywords)
          base_scope = add_search_scopes(base_scope)
          base_scope = add_eagerload_scopes(base_scope)
          base_scope = apply_sort_scopes(base_scope)
          base_scope
        end

        def apply_sort_scopes(product_scope)
          sort_scope = product_scope
          case
          when sort_by && sort_by == 'ascend_by_updated_at'
            sort_scope = sort_scope.ascend_by_updated_at
          when sort_by && sort_by == 'ascend_by_master_price'
            sort_scope = sort_scope.ascend_by_master_price
          when sort_by && sort_by == 'ascend_by_name'
            sort_scope = sort_scope.ascend_by_name
          else
            sort_scope = sort_scope.descend_by_updated_at
          end

          sort_scope
        end

        def add_eagerload_scopes scope
          # TL;DR Switch from `preload` to `includes` as soon as Rails starts honoring
          # `order` clauses on `has_many` associations when a `where` constraint
          # affecting a joined table is present (see
          # https://github.com/rails/rails/issues/6769).
          #
          # Ideally this would use `includes` instead of `preload` calls, leaving it
          # up to Rails whether associated objects should be fetched in one big join
          # or multiple independent queries. However as of Rails 4.1.8 any `order`
          # defined on `has_many` associations are ignored when Rails builds a join
          # query.
          #
          # Would we use `includes` in this particular case, Rails would do
          # separate queries most of the time but opt for a join as soon as any
          # `where` constraints affecting joined tables are added to the search;
          # which is the case as soon as a taxon is added to the base scope.
          scope = scope.preload(master: :prices)
          scope = scope.preload(master: :images) if include_images
          scope
        end

        def add_search_scopes(base_scope)
          search.each do |name, scope_attribute|
            scope_name = name.to_sym
            if base_scope.respond_to?(:search_scopes) && base_scope.search_scopes.include?(scope_name.to_sym)
              base_scope = base_scope.send(scope_name, *scope_attribute)
            else
              base_scope = base_scope.merge(Spree::Product.ransack({scope_name => scope_attribute}).result)
            end
          end if search.is_a?(Hash)
          base_scope
        end

        # method should return new scope based on base_scope
        def get_products_conditions_for(base_scope, query)
          unless query.blank?
            base_scope = base_scope.like_any([:name], query.split)
          end
          base_scope
        end

        def prepare(params)
          @properties[:taxon] = params[:taxon].blank? ? nil : Spree::Taxon.find(params[:taxon])
          @properties[:taxons] = params[:taxons].nil? ? nil : Spree::Taxon.where(id: params[:taxons])
          @properties[:keywords] = params[:keywords]
          @properties[:search] = params[:search]
          @properties[:sort_by] = params[:sort_by]
          @properties[:include_images] = params[:include_images]

          per_page = params[:per_page].to_i
          @properties[:per_page] = per_page > 0 ? per_page : Spree::Config[:products_per_page]
          if params[:page].respond_to?(:to_i)
            @properties[:page] = (params[:page].to_i <= 0) ? 1 : params[:page].to_i
          else
            @properties[:page] = 1
          end
        end
 
        def custom_filter_by_taxons(taxons, base_scope)
          taxonomies_ids = Spree::Taxonomy.pluck(:id).first(2)
          last_taxonomy  = Spree::Taxonomy.pluck(:id).last

          last_taxonomy_taxons = Spree::Taxon.where({id: taxons, taxonomy_id: last_taxonomy}).uniq.pluck(:id)
          if last_taxonomy_taxons.present?
            return base_scope.in_taxons(last_taxonomy_taxons)
          else
            parent_taxons  = Spree::Taxon.where({id: taxons, taxonomy_id: taxonomies_ids.first}).uniq.pluck(:id)
            child_taxons   = Spree::Taxon.where({id: taxons, taxonomy_id: taxonomies_ids.last}).uniq.pluck(:id)

            products_for_parent = base_scope.in_taxons(parent_taxons)
            products_for_child  = base_scope.in_taxons(child_taxons)
            return products_for_parent.where(id: products_for_child.pluck(:id))
          end
          base_scope
        end

    end
  end
end
