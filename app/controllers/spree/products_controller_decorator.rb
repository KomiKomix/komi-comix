Spree::ProductsController.class_eval do
  rescue_from ActiveRecord::RecordNotFound, with: :error404
  before_filter :set_active_pic, only: :show

  def index
    @searcher   = build_searcher(params.merge(include_images: true))
    @taxons     = @searcher.taxons.pluck(:id) if @searcher.taxons.present?
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

  def error404
    render :file => "#{Rails.root}/public/404.html", status: 404, :layout => false
  end

  private

  def set_active_pic
    if @product.images.present?
      @active_pic_id = params[:active_pic_id].present? ? params[:active_pic_id].to_i : @product.images.first.id
    end
  end

  def sorting_scope
    allowed_sortings.include?(sorting_param) ? sorting_param : default_sorting
  end

  def default_sorting
    :ascend_by_updated_at
  end

  def allowed_sortings
    [:descend_by_master_price, :ascend_by_caption_and_name, :ascend_by_updated_at]
  end
end
