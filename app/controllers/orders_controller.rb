class OrdersController < ApplicationController
  def new
    @menu_items = MenuItemFetcher.menu_items
    @form = OrderForm.new(Order.new)
  end

  def create
    @order = Order.new(order_params)

    if @order.save
      redirect_to @order, notice: 'Order successfully created, pending payment'
      return
    end

    @menu_items = MenuItemFetcher.menu_items
    render :new
  end

  def edit
    @order = Order.find(params["id"])
  end

  def show
    @order = Order.find(params["id"])
  end

  def update
    @order = Order.find(params["id"])

    kitchen_response = JobPoster.new(@order).send_order_to_kitchen

    if kitchen_response.success?
      @order.update(status: "in progress")
      # Code to run job that listens to kitchen api goes here
    else
      @errors = JSON.parse(kitchen_response.body)["errors"]
      @order.update(status: "rejected by kitchen")
    end

    render :show
  end

  private

  def order_params
    params.require(:order).permit(order_items_attributes: [:menu_item_id, :menu_item_name, :quantity, :_destroy])
  end
end
