class CreateExpenseAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :expenses do |t|
      t.string :name, limit: 255, null: false
      t.string :user_uid, limit: 25, null: false
      t.string :base_currency, limit: 10, null: false, default: :usd
      t.decimal :month_expenses,  precision: 12, scale: 2

      t.timestamps
    end

    add_index :expenses, %i[name user_uid], unique: true
  end
end
