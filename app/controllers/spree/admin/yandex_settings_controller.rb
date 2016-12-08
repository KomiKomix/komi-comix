module Spree
  module Admin
    class YandexSettingsController < ResourceController
      def update
        settings = Spree::YandexSetting.new
        preferences = params && params.key?(:preferences) ? params.delete(:preferences) : params
        preferences.each do |name, value|
          next unless settings.has_preference? name.to_param
          settings[name] = value
        end
        flash[:success] = Spree.t(:successfully_updated, resource: Spree.t(:settings, scope: :yandex))
        redirect_to edit_admin_yandex_settings_path
      end
    end
  end
end
