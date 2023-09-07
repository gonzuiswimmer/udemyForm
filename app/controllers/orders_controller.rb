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
        session[:order_id] = @order.id
        redirect_to complete_orders_url
      else
        render :confirm
      end
    end
  end

  def complete
    @order = Order.find_by(id: session[:order_id])
    if @order.blank?
      redirect_to new_order_path
    end
    session[:order_id] = nil
  end
  


  private
  def order_params
    params.require(:order).permit(:name,:email,:telephone,:delivery_address)
  end
end
