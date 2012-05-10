require 'spec_helper'

describe "to_accountants/edit" do
  before(:each) do
    @to_accountant = assign(:to_accountant, stub_model(ToAccountant,
      :label => "MyString"
    ))
  end

  it "renders the edit to_accountant form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => to_accountants_path(@to_accountant), :method => "post" do
      assert_select "input#to_accountant_label", :name => "to_accountant[label]"
    end
  end
end
