require 'spec_helper'

describe "invoice_statuses/new" do
  before(:each) do
    assign(:invoice_status, stub_model(InvoiceStatus,
      :label => "MyString"
    ).as_new_record)
  end

  it "renders new invoice_status form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => invoice_statuses_path, :method => "post" do
      assert_select "input#invoice_status_label", :name => "invoice_status[label]"
    end
  end
end
