class AddFooterOptionToSpreePages < ActiveRecord::Migration
  def self.up
    add_column :spree_pages, :footer, :boolean, default: false, null: false
  end

  def self.down
    remove_column :spree_pages, :footer
  end
end
