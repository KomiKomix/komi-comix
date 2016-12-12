Deface::Override.new(
    virtual_path:  'spree/admin/shared/sub_menu/_configuration',
    name:          'add_addtoany_to_configurations_menu',
    insert_bottom: '[data-hook="admin_configurations_sidebar_menu"]',
    text:          '<%= configurations_sidebar_menu_item Spree.t(:settings, scope: :addtoany), edit_admin_addtoany_settings_path %>'
)