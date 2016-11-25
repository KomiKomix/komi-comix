Spree::Product.class_eval do
  translates :caption
  scope :rand, -> { order('RANDOM()').limit(3) }

  before_save :set_position

  def initialize(*args)
    super(*args)
    self.available_on = DateTime.current.strftime('%d.%m.%Y')
    # self.option_types =
    self.shipping_category = Spree::ShippingCategory.first
  end

  add_search_scope :ascend_by_caption_and_name do
    order([caption: :asc]) #, name: :asc])
  end
end
