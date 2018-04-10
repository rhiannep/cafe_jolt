require "spec_helper"

describe Order do
  describe "#create" do
    it "commits a new order to the db" do
      expect { Order.create }.to change{ Order.count }.by(1)
    end
  end
end
