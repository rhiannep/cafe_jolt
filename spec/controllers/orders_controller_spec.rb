require "rails_helper"

describe OrdersController do
  describe "#create" do
    context "when given the correct params" do
      before(:each) do
        allow(MenuItemFetcher).to receive(:stock_level_for).and_return(1)
        order_form_data = { order_items_attributes: [{ quantity: 1, menu_item_id: "menu_item_id"}]}

        post :create, params: { order: order_form_data, commit: "submit" }
      end

      it "creates and order" do
      end

      it "returns 302" do
        expect(response.status).to eq(302)
      end

      it "redirects to show" do
        expect redirect_to(Order.last)
      end
    end

    context "when given incorrect params" do
      before(:each) do
        allow(MenuItemFetcher).to receive(:stock_level_for).and_return(1)
        order_form_data = { order_items_attributes: [{ menu_item_id: "menu_item_id"}]}

        post :create, params: { order: order_form_data, commit: "submit" }
      end
      it "returns 200" do
        expect(response.status).to eq(200)
      end

      it "renders #new" do
        expect(response).to render_template(:new)
      end
    end
  end


  describe "#new" do
    it "returns 200" do
      get :new
      expect(response.status).to eq(200)
    end
  end

  describe "#update" do
    context "when the order is approved by the kitchen" do
      before(:each) do
        allow(MenuItemFetcher).to receive(:stock_level_for).and_return(1)
        response = double
        allow(response).to receive(:success?).and_return(true)
        allow(JobPoster)
          .to receive_message_chain(:new, :send_order_to_kitchen)
          .and_return(response)
      end

      let(:order) do
        order_form_data = {
          order_items_attributes: [{ quantity: 1, menu_item_id: "menu_item_id"}]
        }
        Order.create(order_form_data)
      end

      it "returns 200" do
        put :update, params: {id: order.id}
        expect(response.status).to eq(200)
      end

      it "sends the order to the kitchen" do
        put :update, params: {id: order.id}
        expect(JobPoster).to have_received(:new)
      end

      it "updates the order status" do
        put :update, params: {id: order.id}
        expect(Order.find(order.id).status).to eq("in progress")
      end

      it "renders the show template" do
        put :update, params: {id: order.id}
        expect(response).to render_template(:show)
      end
    end

    context "when the order is rejected" do
      before(:each) do
        allow(MenuItemFetcher).to receive(:stock_level_for).and_return(1)
        response = double
        allow(response).to receive(:success?).and_return(false)
        allow(response)
          .to receive_message_chain(:body)
          .and_return({errors: [title: "error"]}.to_json)
        allow(JobPoster)
          .to receive_message_chain(:new, :send_order_to_kitchen)
          .and_return(response)
      end

      let(:order) do
        order_form_data = {
          order_items_attributes: [{ quantity: 1, menu_item_id: "menu_item_id"}]
        }
        Order.create(order_form_data)
      end

      it "returns 200" do
        put :update, params: {id: order.id}
        expect(response.status).to eq(200)
      end

      it "sends the order to the kitchen" do
        put :update, params: {id: order.id}
        expect(JobPoster).to have_received(:new)
      end

      fit "updates the order status" do
        put :update, params: {id: order.id}
        expect(Order.find(order.id).status).to eq("rejected by kitchen")
      end

      it "renders the show template" do
        put :update, params: {id: order.id}
        expect(response).to render_template(:show)
      end
    end
  end
end
