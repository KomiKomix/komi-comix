module Spree
  class YandexSetting < Preferences::Configuration
    preference :metrika_enabled, :boolean, default: true
    preference :metrika_html, :text, default: ''
    preference :webmaster_verification_enabled, :boolean, default: true
    preference :webmaster_verification_code, :string, default: ''
  end
end
