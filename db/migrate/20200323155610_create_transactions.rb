class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.integer :amount
      t.integer :initial_balance
      t.integer :final_balance
      t.integer :sender_id
      t.integer :receiver_id
      t.integer :account_id
      t.string :status, default: 'pending'

      t.timestamps
    end
  end
end
