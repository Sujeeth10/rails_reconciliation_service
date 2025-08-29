class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.string :txn_id, null: false
      t.decimal :amount, precision: 12, scale: 2, null: false, default: 0.0
      t.string :status, null: false, default: 'pending'
      t.datetime :processed_at
      t.timestamps
    end
    add_index :transactions, :txn_id, unique: true
  end
end
