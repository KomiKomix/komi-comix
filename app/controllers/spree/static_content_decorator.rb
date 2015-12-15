Spree::StaticContentController.class_eval do
  include ActionView::Helpers::NumberHelper
  rescue_from ActiveRecord::RecordNotFound, with: :page_not_found

  def show
    @page = Spree::Page.visible.find_by_slug!(request.path)
  end

  private


end
