class CreateLoanInstallments < ActiveRecord::Migration[6.1]
  def change
    create_table :loan_installments do |t|
      t.references :bank_loan, foreign_key: true
      t.datetime :due_date
      t.float :value
      t.boolean :status

      t.timestamps
    end
  end
end
