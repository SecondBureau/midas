require 'spec_helper'

describe "payment_statuses/show" do
  before(:each) do
    @payment_status = assign(:payment_status, stub_model(PaymentStatus,
      :label => "Label"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Label/)
  end
end
