require 'spec_helper'

describe "to_accountants/show" do
  before(:each) do
    @to_accountant = assign(:to_accountant, stub_model(ToAccountant,
      :label => "Label"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Label/)
  end
end
