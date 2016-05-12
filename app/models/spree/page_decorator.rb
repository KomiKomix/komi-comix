Spree::Page.class_eval do
  scope :banners, -> { where({it_banner: true, visible: true}) }
  scope :in_top_menu, -> { where({show_in_header: true, visible: true}).order(position: :asc) }

  def self.has_banner?
    banners.present?
  end

  def self.main_banner
    banners.first
  end
end
