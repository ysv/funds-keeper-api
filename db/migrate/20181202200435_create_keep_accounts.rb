class CreateKeepAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :keep_accounts do |t|
      t.string :name, limit: 255, null: false
      t.string :user_uid, limit: 25, null: false
      t.string :base_currency, limit: 10, null: false, default: :usd

      t.timestamps
    end

    add_index :keep_accounts, %i[name user_uid], unique: true
  end
end
