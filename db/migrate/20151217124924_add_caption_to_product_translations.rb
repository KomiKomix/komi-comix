class AddCaptionToProductTranslations < ActiveRecord::Migration
  def up
    add_column :spree_product_translations, :caption, :string
  end

  def down
    remove_column :spree_product_translations, :caption
  end
end
