Spree::Product.class_eval do
  translates :name_main, :name_extra
  scope :rand, -> { order('RANDOM()').limit(3) }

  validates :name_main, presence: true

  before_save :set_name
  before_validation :set_name
  before_validation :strip_data

  def slug_candidates
    [
        [:name_main, :name_extra],
        :name,
        [:name, :sku],
    ]
  end

  def initialize(*args)
    super(*args)
    self.available_on = DateTime.current.strftime('%d.%m.%Y')
    self.shipping_category = Spree::ShippingCategory.first
    prototype = Spree::Prototype.where(name: 'books').first
    if prototype
      self.prototype_id = prototype.id
    end
  end

  self.whitelisted_ransackable_attributes = %w[slug created_at]

  def set_name
    if self.name_main or self.name_extra
      self.name = "#{self.name_main} #{self.name_extra}".strip
    end
  end

  def duplicate_extra(product)
    self.name_main = "COPY OF #{product.name_main}"
    self.name_extra = product.name_extra
  end

  def strip_data
    if self.name_main
      self.name_main = self.name_main.strip
    end
    if self.name_extra
      self.name_extra = self.name_extra.strip
    end
  end

end
