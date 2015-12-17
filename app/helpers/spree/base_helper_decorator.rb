module Spree
  module BaseHelper
    def taxons_tree(root_taxon, current_taxon, max_level = 1)
      return '' if max_level < 1 || root_taxon.nil? #|| root_taxon.leaf?
      content_tag :div, class: 'list-group' do
        root_taxon.children.map do |taxon|
          css_class = (current_taxon && current_taxon.self_and_ancestors.include?(taxon)) ? 'list-group-item active' : 'list-group-item'
          link_to(taxon.name, seo_url(taxon), class: css_class) + taxons_tree(taxon, current_taxon, max_level - 1)
        end.join("\n").html_safe
      end
    end

    def search_form
      form_for products_path, method: :get, remote: true, id: 'products_search' do
        content_tag(:div, class: 'input-group search') do
          search_field_tag(:keywords, params[:keywords], placeholder: 'Найди свой комикс...', class: 'form-control', type: 'text') +
          content_tag(:div, search_button, class: 'input-group-btn')
        end
      end
    end

    def search_button
      content_tag(:button, class: 'btn', type: 'button') do
        "<i class='fa fa-search'></i>".html_safe
      end
    end

    def take_your_chance_block_links
      Spree::Product.rand.collect do |product|
        link_to product_url(product), class: 'list-group-item' do
          content_tag(:h4, product.caption, class: 'list-group-item-heading') +
          content_tag(:p, product.name, class: 'list-group-item-text')
        end
      end
    end
  end
end