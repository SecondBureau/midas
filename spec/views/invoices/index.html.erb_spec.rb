require 'spec_helper'

describe "invoices/index" do
  before(:each) do
    assign(:invoices, [
      stub_model(Invoice,
        :category => nil,
        :payment_mode => nil,
        :description => "Description",
        :amount => "9.99",
        :invoice_status => nil,
        :cheque_number => "Cheque Number",
        :invoice_number => "Invoice Number",
        :to_accountant => nil,
        :bank => nil
      ),
      stub_model(Invoice,
        :category => nil,
        :payment_mode => nil,
        :description => "Description",
        :amount => "9.99",
        :invoice_status => nil,
        :cheque_number => "Cheque Number",
        :invoice_number => "Invoice Number",
        :to_accountant => nil,
        :bank => nil
      )
    ])
  end

  it "renders a list of invoices" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Cheque Number".to_s, :count => 2
    assert_select "tr>td", :text => "Invoice Number".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
