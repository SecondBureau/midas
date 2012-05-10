require 'spec_helper'

describe "payment_statuses/new" do
  before(:each) do
    assign(:payment_status, stub_model(PaymentStatus,
      :label => "MyString"
    ).as_new_record)
  end

  it "renders new payment_status form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => payment_statuses_path, :method => "post" do
      assert_select "input#payment_status_label", :name => "payment_status[label]"
    end
  end
end
