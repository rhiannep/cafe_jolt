class Order < ApplicationRecord
  has_many :order_items
  validates_presence_of :order_items
  validates_associated :order_items
  accepts_nested_attributes_for :order_items, reject_if: :all_blank, allow_destroy: true

  def send_to_kitchen
    response = JobPoster.new(self).post_order

    if response.success?
      update(status: "in progress")
    end
  end
end
