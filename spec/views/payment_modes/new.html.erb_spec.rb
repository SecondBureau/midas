require 'spec_helper'

describe "payment_modes/new" do
  before(:each) do
    assign(:payment_mode, stub_model(PaymentMode,
      :label => "MyString"
    ).as_new_record)
  end

  it "renders new payment_mode form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => payment_modes_path, :method => "post" do
      assert_select "input#payment_mode_label", :name => "payment_mode[label]"
    end
  end
end
