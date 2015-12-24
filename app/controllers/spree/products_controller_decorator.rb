Spree::ProductsController.class_eval do
  rescue_from ActiveRecord::RecordNotFound, with: :page_not_found

  def index
    #@taxons = params[:taxons]
    @searcher   = build_searcher(params.merge(include_images: true))
    #raise @searcher.inspect
    @taxons = @searcher.taxons.pluck(:id) if @searcher.taxons.present?
    @products   = @searcher.retrieve_products
    @taxonomies = Spree::Taxonomy.includes(root: :children)
    respond_to do |format|
      format.js
      format.html
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
