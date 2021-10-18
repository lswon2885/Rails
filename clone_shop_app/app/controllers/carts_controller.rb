class CartsController < ApplicationController
  before_action :authenticate_user!

  def index
    @carts = current_user.carts


    @product_price = 0
    @carts.each do |cart|
    # @product_price = @product_price + cart.quantity * cart.pack.price
    @product_price += cart.quantity * cart.pack.price
    end

    if @product_price > 15000
      @shipping_fee = 0
      else
        @shipping_fee = 2500
    end

    @total_price = @product_price + @shipping_fee
  end

  def create
    cart = Cart.new(
      pack_id: params[:pack_id], 
      user: current_user,
      quantity: params[:quantity],
    )
    sample_carts = current_user.carts

    #기존에 내가 같은 제품 등록했는지 찾기
    remain_cart = sample_carts.find_by(pack_id: cart.pack_id)

    if remain_cart.present?
      sum_quantity = remain_cart.quantity + cart.quantity.to_i

      remain_cart.update(quantity: sum_quantity)
    else
      cart.save
    end
   
     
    @notice = "장바구니에 상품이 담겼습니다.장바구니로 이동하시겠습니까?"
  
    respond_to do |format|
      format.js
    end
  end

 
  def destroy
    cart = Cart.find(params[:id])
    
    cart.destroy
    redirect_back(fallback_location: root_path)
  end
end
