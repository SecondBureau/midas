require 'spec_helper'

describe "to_accountants/index" do
  before(:each) do
    assign(:to_accountants, [
      stub_model(ToAccountant,
        :label => "Label"
      ),
      stub_model(ToAccountant,
        :label => "Label"
      )
    ])
  end

  it "renders a list of to_accountants" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Label".to_s, :count => 2
  end
end
