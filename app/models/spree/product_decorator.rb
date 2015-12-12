Spree::Product.class_eval do
  scope :rand, -> { order('RANDOM()').limit(3) }
end
