Deface::Override.new(
    virtual_path:  'spree/admin/shared/sub_menu/_configuration',
    name:          'add_yandex_to_configurations_menu',
    insert_bottom: '[data-hook="admin_configurations_sidebar_menu"]',
    text:          '<%= configurations_sidebar_menu_item Spree.t(:settings, scope: :yandex), edit_admin_yandex_settings_path %>'
)