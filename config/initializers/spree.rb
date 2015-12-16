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



Spree.config do |config|
  # Example:
  # Uncomment to stop tracking inventory levels in the application
  # config.track_inventory_levels = false

  #config.allow_ssl_in_staging = true
  #config.allow_ssl_in_production = true
  config.logo = 'logo/favicon.ico'
  config.layout = 'application'
  #config.default_country_id = 72
  config.products_per_page = 12
  config.allow_guest_checkout = true
  config.always_include_confirm_step = true
  #config.mails_from = ""
  #config.facebook_app_id = '844425155590323'
  #config.facebook_layout = 'button_count'
  #config.order_emails_bcc = ''
  #config.delivery_time_in_days = 3
  #config.searcher_class = Spree::Search::YgiSearch
  #config.use_common_meta = true
  #config.taxon_use_common_meta = true


  #S3 configuration
  if Rails.env.production?
    #production. Store images on S3.
    # development will default to local storage

    attachment_config = {

      s3_credentials: {
        access_key_id:     ENV['AWS_ACCESS_KEY_ID'],
        secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
        bucket:            ENV['S3_BUCKET']
      },

      storage:        :s3,
      s3_headers:     { "Cache-Control" => "max-age=31557600" },
      s3_protocol:    "https",
      bucket:         ENV['S3_BUCKET'],
      url:            ":s3_domain_url",

      styles: {
          mini:     "48x48>",
          small:    "100x100>",
          product:  "240x240>",
          large:    "600x600>"
      },

      path:           "/:class/:id/:style/:basename.:extension",
      default_url:    "/:class/:id/:style/:basename.:extension",
      default_style:  "product"
    }

    attachment_config.each do |key, value|
      Spree::Image.attachment_definitions[:attachment][key.to_sym] = value
    end
  end
end

Spree.user_class = "Spree::LegacyUser"

Spree::Frontend::Config.locale = :ru
Spree::Backend::Config.locale = :ru

Spree::Auth::Config.signout_after_password_change = false

#Spree::PermittedAttributes.taxon_attributes << :short_description
# Add terms_and_conditions to strong parameters
#Spree::PermittedAttributes.checkout_attributes << :terms
#Spree::PermittedAttributes.user_attributes << :subscribe

#config = Rails.application.config
#config.spree.calculators.shipping_methods << Spree::Calculator::Shipping::GlsPriceSack