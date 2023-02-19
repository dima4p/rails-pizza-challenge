require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

describe "/orders", type: :request do
  before :each do
    allow_any_instance_of(OrdersController).to receive(:current_user)
        .and_return(current_user)
    allow_any_instance_of(Ability).to receive(:can?).and_return true
  end

  # This should return the minimal set of attributes required to create a valid
  # Order. As you add validations to Order, be sure to
  # adjust the attributes here as well. The list could not be empty.
  let(:order) {create :order}
  let(:promotion) {create :promotion}

  let(:valid_attributes) {{promotion_ids: [promotion.id]}}

  let(:invalid_attributes) do
    # {state: ''}
    skip("Add a hash of attributes invalid for your model")
  end

  describe "GET /index" do
    subject(:get_index) {get orders_url}

    it "renders a successful response" do
      Order.create! valid_attributes
      get_index
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    subject(:get_show) {get order_url(id: order.to_param)}

    it "renders a successful response" do
      get_show
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    subject(:get_new) {get new_order_url}

    it "renders a successful response" do
      get_new
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    subject(:get_edit) {get edit_order_url(id: order.to_param)}

    it "render a successful response" do
      get_edit
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    subject(:post_create) do
      post orders_url, params: { order: attributes }
    end

    context "with valid parameters" do
      let(:attributes) {valid_attributes}

      it "creates a new Order" do
        expect{post_create}.to change(Order, :count).by(1)
      end

      it "redirects to the created order" do
        post_create
        expect(response).to redirect_to(order_url(id: Order.last.to_param))
      end
    end

    context "with invalid parameters" do
      let(:attributes) {invalid_attributes}

      it "does not create a new Order" do
        expect {post_create}.not_to change(Order, :count)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post_create
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /update" do
    subject(:patch_update) do
      patch order_url(id: order.to_param), params: { order: attributes }
    end

    context "with valid parameters" do
      let(:new_promotion) {create :promotion}
      let(:attributes) { {promotion_ids: [new_promotion.slug]} }

      it "updates the requested order" do
        # expect_any_instance_of(Order)
        #   .to receive(:update).with(attributes.inject({}){|_, (k, v)| _[k] = v.to_s; _})
        patch_update
        order.reload
        # skip("Add assertions for updated state")
        expect(order.promotions).to eq [new_promotion]
      end

      it "redirects to the orders list" do
        patch_update
        order.reload
        expect(response).to redirect_to(orders_url)
      end
    end

    context "with invalid parameters" do
      let(:attributes) {invalid_attributes}

      it "renders a successful response (i.e. to display the 'edit' template)" do
        patch_update
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    subject(:delete_destroy) {delete order_url(id: order.to_param)}

    it "destroys the requested order" do
      order
      expect {delete_destroy}.to change(Order, :count).by(-1)
    end

    it "redirects to the orders list" do
      order
      delete_destroy
      expect(response).to redirect_to(orders_url)
    end
  end
end
