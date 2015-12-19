Spree::Post.class_eval do
  scope :published, -> { where(published: true).order(created_at: 'desc') }
end
