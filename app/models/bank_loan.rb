class BankLoan < ApplicationRecord
  has_many :loan_installment, dependent: :destroy

  belongs_to :bank
  belongs_to :client
end
