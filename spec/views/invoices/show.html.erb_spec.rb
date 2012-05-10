require 'spec_helper'

describe "invoices/show" do
  before(:each) do
    @invoice = assign(:invoice, stub_model(Invoice,
      :category => nil,
      :payment_mode => nil,
      :description => "Description",
      :amount => "9.99",
      :invoice_status => nil,
      :cheque_number => "Cheque Number",
      :invoice_number => "Invoice Number",
      :to_accountant => nil,
      :bank => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(/Description/)
    rendered.should match(/9.99/)
    rendered.should match(//)
    rendered.should match(/Cheque Number/)
    rendered.should match(/Invoice Number/)
    rendered.should match(//)
    rendered.should match(//)
  end
end
