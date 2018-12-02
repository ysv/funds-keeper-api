class CreateIncomes < ActiveRecord::Migration[5.2]
  def change
    create_table :incomes do |t|
      t.string      :description, limit: 255
      t.belongs_to  :keep_account

      t.datetime :recorded_at
      t.timestamps
    end
  end
end
