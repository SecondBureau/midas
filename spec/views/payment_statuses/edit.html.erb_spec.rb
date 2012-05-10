require 'spec_helper'

describe "payment_statuses/edit" do
  before(:each) do
    @payment_status = assign(:payment_status, stub_model(PaymentStatus,
      :label => "MyString"
    ))
  end

  it "renders the edit payment_status form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => payment_statuses_path(@payment_status), :method => "post" do
      assert_select "input#payment_status_label", :name => "payment_status[label]"
    end
  end
end
