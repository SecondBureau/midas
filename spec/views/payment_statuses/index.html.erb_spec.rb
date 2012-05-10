require 'spec_helper'

describe "payment_statuses/index" do
  before(:each) do
    assign(:payment_statuses, [
      stub_model(PaymentStatus,
        :label => "Label"
      ),
      stub_model(PaymentStatus,
        :label => "Label"
      )
    ])
  end

  it "renders a list of payment_statuses" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Label".to_s, :count => 2
  end
end
