Spree::Product.class_eval do
  translates :caption
  scope :rand, -> { order('RANDOM()').limit(3) }

  def initialize(*args)
    super(*args)
    self.available_on = DateTime.current.strftime('%d.%m.%Y')
    self.shipping_category = Spree::ShippingCategory.first
    prototype = Spree::Prototype.where(name: 'books').first
    if prototype
      self.prototype_id = prototype.id
    end
  end

  def name_with_caption
    "#{self.name} #{self.caption}".strip
  end

  self.whitelisted_ransackable_attributes = %w[slug caption created_at]

  add_search_scope :ascend_by_caption_and_name do
    order([caption: :asc]) #, name: :asc])
  end
end
