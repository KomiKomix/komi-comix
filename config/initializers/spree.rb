# coding: utf-8
# Configure Spree Preferences
#
# Note: Initializing preferences available within the Admin will overwrite any changes that were made through the user interface when you restart.
#       If you would like users to be able to update a setting with the Admin it should NOT be set here.
#
# Note: If a preference is set here it will be stored within the cache & database upon initialization.
#       Just removing an entry from this initializer will not make the preference value go away.
#       Instead you must either set a new value or remove entry, clear cache, and remove database entry.
#
# In order to initialize a setting do:
# config.setting_name = 'new value'
require 'spree/search/KomiComixSearch'


Spree.config do |config|
  # Example:
  # Uncomment to stop tracking inventory levels in the application
  # config.track_inventory_levels = false

  #config.allow_ssl_in_staging = true
  #config.allow_ssl_in_production = true
  config.logo = 'logo/favicon.ico'
  config.layout = 'application'
  config.default_country_id = 643
  config.products_per_page = 12
  config.allow_guest_checkout = true
  config.always_include_confirm_step = true
  #config.mails_from = ""
  #config.facebook_app_id = '844425155590323'
  #config.facebook_layout = 'button_count'
  #config.order_emails_bcc = ''
  #config.delivery_time_in_days = 3
  config.searcher_class = Spree::Search::KomiComixSearch
  #config.use_common_meta = true
  #config.taxon_use_common_meta = true

  Spree::Money.class_eval do
    def to_s
      @money.format.gsub(/,00/, '')
      @money.format(symbol_position: :after, with_currency: false, no_cents: true)
    end

    def to_html(options = { :html => true })
     to_s
    end
  end
end

Spree.user_class = "Spree::LegacyUser"

Spree::Frontend::Config.locale = :ru
Spree::Backend::Config.locale = :ru

Spree::Auth::Config.signout_after_password_change = false

Spree::Product.whitelisted_ransackable_attributes |= ['caption']

Spree::Auth::Config[:registration_step] = false

Spree::Config[:checkout_zone] = "RU"

Spree::Config[:address_requires_state] = false

#Spree::PermittedAttributes.taxon_attributes << :short_description
# Add terms_and_conditions to strong parameters
#Spree::PermittedAttributes.checkout_attributes << :terms
#Spree::PermittedAttributes.user_attributes << :subscribe

#config = Rails.application.config
#config.spree.calculators.shipping_methods << Spree::Calculator::Shipping::GlsPriceSack
