class Order < ApplicationRecord
  has_many :order_items
  validates_presence_of :order_items
  validates_associated :order_items
  accepts_nested_attributes_for :order_items, reject_if: :all_blank, allow_destroy: true
end
