require 'spec_helper'

describe "invoice_statuses/edit" do
  before(:each) do
    @invoice_status = assign(:invoice_status, stub_model(InvoiceStatus,
      :label => "MyString"
    ))
  end

  it "renders the edit invoice_status form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => invoice_statuses_path(@invoice_status), :method => "post" do
      assert_select "input#invoice_status_label", :name => "invoice_status[label]"
    end
  end
end
