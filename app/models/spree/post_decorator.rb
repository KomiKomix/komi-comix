Spree::Post.class_eval do
  scope :published, -> { where(published: true).order(created_at: 'desc') }

  before_save :fix_invalid_html

  def fix_invalid_html
    if self.description?
      self.description = Nokogiri::HTML::DocumentFragment.parse(self.description).to_html
    end
  end

end
