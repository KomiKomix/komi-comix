Spree::Product.class_eval do
  translates :caption
  scope :rand, -> { order('RANDOM()').limit(3) }

  add_search_scope :ascend_by_caption_and_name do
    order([caption: :asc, name: :asc])
  end
end
