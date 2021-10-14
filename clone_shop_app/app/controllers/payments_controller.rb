class PaymentsController < ApplicationController
  def create
    order = Order.find(params[:order_id])

    if params[:imp_uid].present?
      response = Iamport.payment(params[:imp_uid])

      Payment.create(
        order: order,
        response: response,
        imp_uid: response["response"]["imp_uid"],
        merchant_uid: response["response"]["merchant_uid"],
        amount: response["response"]["amount"]
      )

      order.processed!

      flash[:notice] = "성공적으로 결제되었습니다!"
    else
      error_msg = params[:error_msg]

      order.failed!

      flash[:notice] = error_msg
    end

    redirect_to "/orders"
  end
end