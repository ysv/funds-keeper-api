class CreateExpenses < ActiveRecord::Migration[5.2]
  def change
    create_table :expenses do |t|
      t.string      :description, limit: 255
      t.belongs_to  :keep_account
      t.belongs_to  :expense_category

      t.datetime :recorded_at
      t.timestamps
    end
  end
end
