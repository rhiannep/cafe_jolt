class JobPoster
  include HTTParty
  base_uri "http://localhost:5000"

  def initialize(order)
    @order = order
  end

  def post_order
    response = self.class.post(
      "/jobs",
      body: to_request_body,
      headers: { "Content-Type" => "application/json" }
    )
  end

  private

  def to_request_body
    {
      kind: "job",
      idempotency_key: order.uuid,
      components: order.order_items.map do |item|
          {
            href: "/menu_items/#{item.menu_item_id}",
            quantity: item.quantity
          }
      end
    }.to_json
  end

  attr_reader :order
end
