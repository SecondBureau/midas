require 'spec_helper'

describe "payment_modes/show" do
  before(:each) do
    @payment_mode = assign(:payment_mode, stub_model(PaymentMode,
      :label => "Label"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Label/)
  end
end
