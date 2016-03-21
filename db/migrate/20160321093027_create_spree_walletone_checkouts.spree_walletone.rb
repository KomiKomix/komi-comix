# This migration comes from spree_walletone (originally 20160321085627)
class CreateSpreeWalletoneCheckouts < ActiveRecord::Migration
  def change
    create_table :spree_walletone_checkouts do |t|
      t.string :token
      t.string :payer_id
      t.string :state, default: 'complete'
      t.string :transaction_id
    end
  end
end
