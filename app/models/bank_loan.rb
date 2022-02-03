class BankLoan < ApplicationRecord
  has_many :loan_installment

  belongs_to :bank
  belongs_to :client
end
