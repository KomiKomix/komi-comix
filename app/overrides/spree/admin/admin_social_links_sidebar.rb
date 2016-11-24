Deface::Override.new(
    virtual_path: 'spree/layouts/admin',
    name: 'social_links_admin_sidebar_menu',
    insert_bottom: '#main-sidebar',
    partial: 'spree/admin/shared/social_links_sidebar_menu'
)
