Deface::Override.new(
  virtual_path: 'spree/layouts/admin',
  name: 'news_admin_sidebar_menu',
  insert_bottom: '#main-sidebar',
  partial: 'spree/admin/shared/posts_sidebar_menu'
)
