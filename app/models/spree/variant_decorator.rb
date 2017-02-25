Spree::Variant.class_eval do

  scope :by_num_sku, -> { where('sku ~ ?', '^\d*[0-9]\d*$').order(sku: 'desc') }

  # before_save :set_sku

  def initialize(*args)
    super(*args)
    last_variant = Spree::Variant.by_num_sku.first
    sku = last_variant ? last_variant.sku.to_i + 1 : 1
    self.sku = sku.to_s.rjust(4, '0')
  end

  def set_sku
    if not self.sku
      # TODO: check unique
      last_variant = Spree::Variant.by_num_sku.first
      sku = last_variant ? last_variant.sku.to_i + 1 : 1
      self.sku = sku.to_s.rjust(4, '0')
    end
  end

  def total_orderable
    if self.is_backorderable?
      return nil
    else
      on_hand = self.total_on_hand
      if on_hand == Float::INFINITY
        return nil
      elsif on_hand >= 0
        return on_hand
      end
    end
    return nil
  end
end
