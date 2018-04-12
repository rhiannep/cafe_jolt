class OrdersController < ApplicationController
  # GET /orders/new
  def new
    @order = Order.new
    @menu_items = MenuItemFetcher.menu_items
  end

  # POST /orders
  def create
    @order = Order.new(order_params)
    @menu_items = MenuItemFetcher.menu_items

    if @order.save
      redirect_to menu_items_path, notice: 'Order was successfully created'
      return
    else
      render :new
    end
  end

  private

  def order_params
    params.require(:order).permit(order_items_attributes: [:menu_item_id, :quantity, :_destroy])
  end
end
