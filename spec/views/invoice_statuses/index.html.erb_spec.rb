require 'spec_helper'

describe "invoice_statuses/index" do
  before(:each) do
    assign(:invoice_statuses, [
      stub_model(InvoiceStatus,
        :label => "Label"
      ),
      stub_model(InvoiceStatus,
        :label => "Label"
      )
    ])
  end

  it "renders a list of invoice_statuses" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Label".to_s, :count => 2
  end
end
