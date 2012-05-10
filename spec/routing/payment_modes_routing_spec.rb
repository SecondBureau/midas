require "spec_helper"

describe PaymentModesController do
  describe "routing" do

    it "routes to #index" do
      get("/payment_modes").should route_to("payment_modes#index")
    end

    it "routes to #new" do
      get("/payment_modes/new").should route_to("payment_modes#new")
    end

    it "routes to #show" do
      get("/payment_modes/1").should route_to("payment_modes#show", :id => "1")
    end

    it "routes to #edit" do
      get("/payment_modes/1/edit").should route_to("payment_modes#edit", :id => "1")
    end

    it "routes to #create" do
      post("/payment_modes").should route_to("payment_modes#create")
    end

    it "routes to #update" do
      put("/payment_modes/1").should route_to("payment_modes#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/payment_modes/1").should route_to("payment_modes#destroy", :id => "1")
    end

  end
end
