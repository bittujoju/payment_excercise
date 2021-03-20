class PaymentsController < ActionController::API

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: 'not_found', status: :not_found
  end

  # Sample Call
  #   curl --location --request POST 'http://localhost:3600/payments' \
  # --header 'Content-Type: application/json' \
  # --data-raw '{
  #     "loan_id" : 1,
  #     "amount" : 1000
  # }'
  def create
    begin
      loan = Loan.find(params[:loan_id])
      amount = params["amount"].to_f

      raise "Invalid Loan" unless loan.present?
      raise "Invalid Amount" unless amount > 0

      Payment.create({loan: loan, amount: amount})
    rescue Exception => e
      render json: {message: "Exception in Payment Create: #{e.message}"}
    else
      render json: {message: "Payment Successful"}
    end
  end
end
