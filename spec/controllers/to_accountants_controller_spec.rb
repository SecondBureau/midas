require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe ToAccountantsController do

  # This should return the minimal set of attributes required to create a valid
  # ToAccountant. As you add validations to ToAccountant, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end
  
  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ToAccountantsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all to_accountants as @to_accountants" do
      to_accountant = ToAccountant.create! valid_attributes
      get :index, {}, valid_session
      assigns(:to_accountants).should eq([to_accountant])
    end
  end

  describe "GET show" do
    it "assigns the requested to_accountant as @to_accountant" do
      to_accountant = ToAccountant.create! valid_attributes
      get :show, {:id => to_accountant.to_param}, valid_session
      assigns(:to_accountant).should eq(to_accountant)
    end
  end

  describe "GET new" do
    it "assigns a new to_accountant as @to_accountant" do
      get :new, {}, valid_session
      assigns(:to_accountant).should be_a_new(ToAccountant)
    end
  end

  describe "GET edit" do
    it "assigns the requested to_accountant as @to_accountant" do
      to_accountant = ToAccountant.create! valid_attributes
      get :edit, {:id => to_accountant.to_param}, valid_session
      assigns(:to_accountant).should eq(to_accountant)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new ToAccountant" do
        expect {
          post :create, {:to_accountant => valid_attributes}, valid_session
        }.to change(ToAccountant, :count).by(1)
      end

      it "assigns a newly created to_accountant as @to_accountant" do
        post :create, {:to_accountant => valid_attributes}, valid_session
        assigns(:to_accountant).should be_a(ToAccountant)
        assigns(:to_accountant).should be_persisted
      end

      it "redirects to the created to_accountant" do
        post :create, {:to_accountant => valid_attributes}, valid_session
        response.should redirect_to(ToAccountant.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved to_accountant as @to_accountant" do
        # Trigger the behavior that occurs when invalid params are submitted
        ToAccountant.any_instance.stub(:save).and_return(false)
        post :create, {:to_accountant => {}}, valid_session
        assigns(:to_accountant).should be_a_new(ToAccountant)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        ToAccountant.any_instance.stub(:save).and_return(false)
        post :create, {:to_accountant => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested to_accountant" do
        to_accountant = ToAccountant.create! valid_attributes
        # Assuming there are no other to_accountants in the database, this
        # specifies that the ToAccountant created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        ToAccountant.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => to_accountant.to_param, :to_accountant => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested to_accountant as @to_accountant" do
        to_accountant = ToAccountant.create! valid_attributes
        put :update, {:id => to_accountant.to_param, :to_accountant => valid_attributes}, valid_session
        assigns(:to_accountant).should eq(to_accountant)
      end

      it "redirects to the to_accountant" do
        to_accountant = ToAccountant.create! valid_attributes
        put :update, {:id => to_accountant.to_param, :to_accountant => valid_attributes}, valid_session
        response.should redirect_to(to_accountant)
      end
    end

    describe "with invalid params" do
      it "assigns the to_accountant as @to_accountant" do
        to_accountant = ToAccountant.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        ToAccountant.any_instance.stub(:save).and_return(false)
        put :update, {:id => to_accountant.to_param, :to_accountant => {}}, valid_session
        assigns(:to_accountant).should eq(to_accountant)
      end

      it "re-renders the 'edit' template" do
        to_accountant = ToAccountant.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        ToAccountant.any_instance.stub(:save).and_return(false)
        put :update, {:id => to_accountant.to_param, :to_accountant => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested to_accountant" do
      to_accountant = ToAccountant.create! valid_attributes
      expect {
        delete :destroy, {:id => to_accountant.to_param}, valid_session
      }.to change(ToAccountant, :count).by(-1)
    end

    it "redirects to the to_accountants list" do
      to_accountant = ToAccountant.create! valid_attributes
      delete :destroy, {:id => to_accountant.to_param}, valid_session
      response.should redirect_to(to_accountants_url)
    end
  end

end
