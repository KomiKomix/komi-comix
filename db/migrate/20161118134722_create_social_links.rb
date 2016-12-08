class CreateSocialLinks < ActiveRecord::Migration
  def change
    create_table :spree_social_links do |t|
      t.string :url, :limit => 300, null: false
      t.boolean :visible, default: true
      t.integer :position, default: 1, null: false

      t.timestamps
    end

    add_index :spree_social_links, [:url], unique: true
  end

  def self.down
    drop_table :spree_social_links
  end
end
