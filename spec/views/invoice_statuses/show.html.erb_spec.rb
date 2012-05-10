require 'spec_helper'

describe "invoice_statuses/show" do
  before(:each) do
    @invoice_status = assign(:invoice_status, stub_model(InvoiceStatus,
      :label => "Label"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Label/)
  end
end
