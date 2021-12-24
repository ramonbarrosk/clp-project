class BankLoan < ApplicationRecord
  belongs_to :client_id
  belongs_to :bank_id
end
