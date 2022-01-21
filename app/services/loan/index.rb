class Loan::Index
  prepend SimpleCommand

  def initialize(client_id)
    @client_id = client_id
  end

  def call
    loans_client = BankLoan.where(client_id: @client_id)
                           .select('type,
                                    requested_amount,
                                    payment_amount,
                                    interest_amount,
                                    total_installments,
                                    status')

    loans_client.map do |loan|
      {
        type: loan.type,
        requested_amount: loan.requested_amount,
        payment_amount: loan.payment_amount,
        interest_amount: loan.interest_amount,
        total_installments: loan.total_installments,
        status: loan.status

      }
    end
  end
end
