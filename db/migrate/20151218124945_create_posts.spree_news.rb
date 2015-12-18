# This migration comes from spree_news (originally 20120312183513)
class CreatePosts < ActiveRecord::Migration
  def change
    create_table :spree_posts do |t|
      t.string :title
      t.text :description
      t.boolean :published

      t.timestamps
    end
  end
end
