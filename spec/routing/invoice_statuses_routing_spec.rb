require "spec_helper"

describe InvoiceStatusesController do
  describe "routing" do

    it "routes to #index" do
      get("/invoice_statuses").should route_to("invoice_statuses#index")
    end

    it "routes to #new" do
      get("/invoice_statuses/new").should route_to("invoice_statuses#new")
    end

    it "routes to #show" do
      get("/invoice_statuses/1").should route_to("invoice_statuses#show", :id => "1")
    end

    it "routes to #edit" do
      get("/invoice_statuses/1/edit").should route_to("invoice_statuses#edit", :id => "1")
    end

    it "routes to #create" do
      post("/invoice_statuses").should route_to("invoice_statuses#create")
    end

    it "routes to #update" do
      put("/invoice_statuses/1").should route_to("invoice_statuses#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/invoice_statuses/1").should route_to("invoice_statuses#destroy", :id => "1")
    end

  end
end
