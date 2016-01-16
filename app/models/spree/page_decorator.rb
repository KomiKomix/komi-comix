Spree::Page.class_eval do
  scope :banners, -> { where({it_banner: true, visible: true}) }

  def self.has_banner?
    banners.present?
  end

  def self.main_banner
    banners.first
  end
end
