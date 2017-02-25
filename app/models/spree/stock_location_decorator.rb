Spree::StockLocation.class_eval do
  # Wrapper for creating a new stock item respecting the backorderable config
  def propagate_variant(variant)
    item = self.stock_items.create!(variant: variant, backorderable: self.backorderable_default)
    item.set_count_on_hand(1)
  end
end