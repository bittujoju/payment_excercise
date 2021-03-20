class Payment < ActiveRecord::Base

  belongs_to :loan

  before_save :validate_payment, :update_loan

  def validate_payment
    unless amount <= loan.outstanding_balance
      raise "Payment Exceeds Outstanding Balance"
    end
  end

  def update_loan
    interest = amount * loan.interest/100
    outstanding_balance = loan.outstanding_balance || loan.funded_amount
    outstanding_balance -= (amount - interest)
    loan.update_attributes({outstanding_balance: outstanding_balance})
  end

end
