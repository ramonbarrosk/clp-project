class CreateBankLoans < ActiveRecord::Migration[6.1]
  def change
    create_table :bank_loans do |t|
      t.references :client, foreign_key: true
      t.references :bank, foreign_key: true
      t.string :loan_type
      t.float :requested_amount
      t.float :payment_amount
      t.float :interest_amount
      t.integer :total_installments
      t.string :status

      t.timestamps
    end
  end
end
