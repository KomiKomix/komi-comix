class AddExtraNameToProduct < ActiveRecord::Migration
  def up
    add_column :spree_products, :name_main, :string, :default => ''
    add_column :spree_products, :name_extra, :string, :default => ''
    add_column :spree_product_translations, :name_main, :string, :default => ''
    add_column :spree_product_translations, :name_extra, :string, :default => ''
  end

  def down
    remove_column :spree_products, :name_main
    remove_column :spree_products, :name_extra
    remove_column :spree_product_translations, :name_main
    remove_column :spree_product_translations, :name_extra
  end
end
