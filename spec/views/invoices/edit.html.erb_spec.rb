require 'spec_helper'

describe "invoices/edit" do
  before(:each) do
    @invoice = assign(:invoice, stub_model(Invoice,
      :category => nil,
      :payment_mode => nil,
      :description => "MyString",
      :amount => "9.99",
      :invoice_status => nil,
      :cheque_number => "MyString",
      :invoice_number => "MyString",
      :to_accountant => nil,
      :bank => nil
    ))
  end

  it "renders the edit invoice form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => invoices_path(@invoice), :method => "post" do
      assert_select "input#invoice_category", :name => "invoice[category]"
      assert_select "input#invoice_payment_mode", :name => "invoice[payment_mode]"
      assert_select "input#invoice_description", :name => "invoice[description]"
      assert_select "input#invoice_amount", :name => "invoice[amount]"
      assert_select "input#invoice_invoice_status", :name => "invoice[invoice_status]"
      assert_select "input#invoice_cheque_number", :name => "invoice[cheque_number]"
      assert_select "input#invoice_invoice_number", :name => "invoice[invoice_number]"
      assert_select "input#invoice_to_accountant", :name => "invoice[to_accountant]"
      assert_select "input#invoice_bank", :name => "invoice[bank]"
    end
  end
end
