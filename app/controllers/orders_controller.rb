class OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def confirm
    @order = Order.new(order_params)
  end

  def create
    @order = Order.new(order_params)
    if params[:button] == 'back'
      render :new
    else
      if @order.save
        redirect_to complete_orders_url
      else
        render :confirm
      end
    end
  end



  private
  def order_params
    params.require(:order).permit(:name,:email,:telephone,:delivery_address)
  end
end
