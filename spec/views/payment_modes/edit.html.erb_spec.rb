require 'spec_helper'

describe "payment_modes/edit" do
  before(:each) do
    @payment_mode = assign(:payment_mode, stub_model(PaymentMode,
      :label => "MyString"
    ))
  end

  it "renders the edit payment_mode form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => payment_modes_path(@payment_mode), :method => "post" do
      assert_select "input#payment_mode_label", :name => "payment_mode[label]"
    end
  end
end
