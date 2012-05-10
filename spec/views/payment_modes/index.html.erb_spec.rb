require 'spec_helper'

describe "payment_modes/index" do
  before(:each) do
    assign(:payment_modes, [
      stub_model(PaymentMode,
        :label => "Label"
      ),
      stub_model(PaymentMode,
        :label => "Label"
      )
    ])
  end

  it "renders a list of payment_modes" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Label".to_s, :count => 2
  end
end
