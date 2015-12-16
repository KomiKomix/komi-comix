Spree::ProductsController.class_eval do
  rescue_from ActiveRecord::RecordNotFound, with: :page_not_found

  def index
    @taxons_ids = params[:taxons_ids] if params[:taxons_ids]
    if @taxons_ids.present?
      arr = []
      @taxons_ids = @taxons_ids.split(',').map { |id| id.to_i }
      @taxons_ids.each do |id|
        searcher = build_searcher(params.merge(taxon: id, include_images: true))
        products = searcher.retrieve_products
        arr.push(products.pluck(:id)).flatten!.uniq
      end
      @searcher   = build_searcher(params.merge(include_images: true))
      @products   = @searcher.retrieve_products.where(id: arr)
      @taxonomies = Spree::Taxonomy.includes(root: :children)

      respond_to do |format|
        format.js
        format.html
      end
    else
      @searcher   = build_searcher(params.merge(include_images: true))
      @products   = @searcher.retrieve_products
      @taxonomies = Spree::Taxonomy.includes(root: :children)
      respond_to do |format|
        format.js
        format.html
      end
    end
  end

  def sorting_param
    params[:sort_by].try(:to_sym) || default_sorting
  end

  private

  def sorting_scope
    allowed_sortings.include?(sorting_param) ? sorting_param : default_sorting
  end

  def default_sorting
    :ascend_by_updated_at
  end

  def allowed_sortings
    [:descend_by_master_price, :ascend_by_name, :ascend_by_updated_at]
  end
end
