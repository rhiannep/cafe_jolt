class OrdersController < ApplicationController
  def new
    @order = Order.new
    @menu_items = MenuItemFetcher.menu_items
  end

  def create
    @order = Order.new(order_params)
    @menu_items = MenuItemFetcher.menu_items

    if @order.save
      redirect_to edit_order_url(@order), notice: 'Order was successfully created'
      return
    else
      render :new
    end
  end

  def show
    @order = Order.find(params["id"])
  end

  def edit
    @order = Order.find(params["id"])
  end

  def update
    @order = Order.find(params["id"])
    # Send order to api here and do error handling
    @order.update(status: "in progress")
    redirect_to @order
  end

  private

  def order_params
    params.require(:order).permit(order_items_attributes: [:menu_item_id, :quantity, :_destroy])
  end
end
