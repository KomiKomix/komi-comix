module Spree

  class SocialLink < ActiveRecord::Base
    default_scope { order(position: :asc) }

    validates :url, presence: true, uniqueness: true, format: {with: URI.regexp}

    scope :visible, -> { where(visible: true) }

    before_save :set_position

    def initialize(*args)
      super(*args)
      last_link = Spree::SocialLink.last
      self.position = last_link ? last_link.position + 1 : 0
      self.visible = true
    end

    def base_domain
      uri_data = URI.parse(self.url)
      return uri_data.host.split('.')[-2]
    rescue URI::InvalidURIError
      return ''
    end

    def set_position
      if not self.position
          last_link = Spree::SocialLink.last
          self.position = last_link ? last_link.position + 1 : 0
      end
    end

  end
end
