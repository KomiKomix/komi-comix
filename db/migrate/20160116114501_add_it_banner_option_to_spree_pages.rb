class AddItBannerOptionToSpreePages < ActiveRecord::Migration
  def self.up
    add_column :spree_pages, :it_banner, :boolean, default: false, null: false
  end

  def self.down
    remove_column :spree_pages, :it_banner
  end
end
