require "rails_helper"

describe OrdersController do
  describe "#create" do
    context "when given the correct params" do
      before(:each) do
        allow(MenuItemFetcher).to receive(:stock_level_for).and_return(1)
        order_form_data = { order_items_attributes: [{ quantity: 1, menu_item_id: "menu_item_id"}]}

        post :create, params: { order: order_form_data, commit: "submit" }
      end

      it "returns 302" do
        expect(response.status).to eq(302)
      end

      it "redirects to menu" do
        expect(response).to redirect_to("/menu_items")
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

    it "fetches the menu items" do
    end
  end
end
