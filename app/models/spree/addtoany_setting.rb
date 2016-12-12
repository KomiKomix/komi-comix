module Spree
  class AddtoanySetting < Preferences::Configuration
    preference :enabled_in_news, :boolean, default: true
    preference :enabled_in_products, :boolean, default: true
    preference :codes_str, :string, default: ''
  end
end
