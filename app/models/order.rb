class Order < Sequel::Model
  plugin :validation_helpers
  plugin :active_model
  plugin :nested_attributes

  one_to_many :order_items
  nested_attributes :order_items, remove: true

  def validate
    super
    validates_presence [:order_items]
  end

  def send_to_kitchen
    response = JobPoster.new(self).send_order_to_kitchen

    if response.success?
      update(status: "in progress")
    end
  end
end
