class CreateOperations < ActiveRecord::Migration[5.2]
  def change
    create_table :operations do |t|
      t.references  :account, null: false, index: true, polymorphic: true
      t.decimal     :debit, null: false, default: 0, precision: 12, scale: 2
      t.decimal     :credit, null: false, default: 0, precision: 12, scale: 2

      t.timestamps
    end
  end
end
