class AddCaptionToProduct < ActiveRecord::Migration
  def change
    add_column :spree_products, :caption, :string, default: ''
  end
end
