Spree::Page.class_eval do
  scope :banners, -> { where({ it_banner: true, visible: true }) }
  scope :footers, -> { where({ footer: true, visible: true }) }
  scope :in_top_menu, -> { where({ show_in_header: true, visible: true }).order(position: :asc) }
  scope :in_bottom_menu, -> { where({ show_in_footer: true, visible: true }).order(position: :asc) }


  def self.has_banner?
    banners.present?
  end

  def self.main_banner
    banners.first
  end

  def self.footer
    footers.first
  end

  def self.footer_contacts
    return Spree::Page.visible.where({ slug: '/_footer_contacts' }).first
  end

  def self.footer_about
    return Spree::Page.visible.where({ slug: '/_footer_about' }).first
  end
end
