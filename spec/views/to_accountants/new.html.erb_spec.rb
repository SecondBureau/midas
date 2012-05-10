require 'spec_helper'

describe "to_accountants/new" do
  before(:each) do
    assign(:to_accountant, stub_model(ToAccountant,
      :label => "MyString"
    ).as_new_record)
  end

  it "renders new to_accountant form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => to_accountants_path, :method => "post" do
      assert_select "input#to_accountant_label", :name => "to_accountant[label]"
    end
  end
end
