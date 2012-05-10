require "spec_helper"

describe ToAccountantsController do
  describe "routing" do

    it "routes to #index" do
      get("/to_accountants").should route_to("to_accountants#index")
    end

    it "routes to #new" do
      get("/to_accountants/new").should route_to("to_accountants#new")
    end

    it "routes to #show" do
      get("/to_accountants/1").should route_to("to_accountants#show", :id => "1")
    end

    it "routes to #edit" do
      get("/to_accountants/1/edit").should route_to("to_accountants#edit", :id => "1")
    end

    it "routes to #create" do
      post("/to_accountants").should route_to("to_accountants#create")
    end

    it "routes to #update" do
      put("/to_accountants/1").should route_to("to_accountants#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/to_accountants/1").should route_to("to_accountants#destroy", :id => "1")
    end

  end
end
