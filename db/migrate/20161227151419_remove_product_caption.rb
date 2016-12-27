class RemoveProductCaption < ActiveRecord::Migration

  def up
    remove_column :spree_products, :caption
    remove_column :spree_product_translations, :caption
  end

  def down
    add_column :spree_products, :caption, :string, :default => ''
    add_column :spree_product_translations, :caption, :string, :default => ''
  end

end
