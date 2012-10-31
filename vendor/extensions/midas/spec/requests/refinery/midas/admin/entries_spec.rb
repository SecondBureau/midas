# encoding: utf-8
require "spec_helper"

describe Refinery do
  describe "Midas" do
    describe "Admin" do
      describe "entries" do
        login_refinery_user

        describe "entries list" do
          before do
            FactoryGirl.create(:entry, :currency => "UniqueTitleOne")
            FactoryGirl.create(:entry, :currency => "UniqueTitleTwo")
          end

          it "shows two items" do
            visit refinery.midas_admin_entries_path
            page.should have_content("UniqueTitleOne")
            page.should have_content("UniqueTitleTwo")
          end
        end

        describe "create" do
          before do
            visit refinery.midas_admin_entries_path

            click_link "Add New Entry"
          end

          context "valid data" do
            it "should succeed" do
              fill_in "Currency", :with => "This is a test of the first string field"
              click_button "Save"

              page.should have_content("'This is a test of the first string field' was successfully added.")
              Refinery::Midas::Entry.count.should == 1
            end
          end

          context "invalid data" do
            it "should fail" do
              click_button "Save"

              page.should have_content("Currency can't be blank")
              Refinery::Midas::Entry.count.should == 0
            end
          end

          context "duplicate" do
            before { FactoryGirl.create(:entry, :currency => "UniqueTitle") }

            it "should fail" do
              visit refinery.midas_admin_entries_path

              click_link "Add New Entry"

              fill_in "Currency", :with => "UniqueTitle"
              click_button "Save"

              page.should have_content("There were problems")
              Refinery::Midas::Entry.count.should == 1
            end
          end

        end

        describe "edit" do
          before { FactoryGirl.create(:entry, :currency => "A currency") }

          it "should succeed" do
            visit refinery.midas_admin_entries_path

            within ".actions" do
              click_link "Edit this entry"
            end

            fill_in "Currency", :with => "A different currency"
            click_button "Save"

            page.should have_content("'A different currency' was successfully updated.")
            page.should have_no_content("A currency")
          end
        end

        describe "destroy" do
          before { FactoryGirl.create(:entry, :currency => "UniqueTitleOne") }

          it "should succeed" do
            visit refinery.midas_admin_entries_path

            click_link "Remove this entry forever"

            page.should have_content("'UniqueTitleOne' was successfully removed.")
            Refinery::Midas::Entry.count.should == 0
          end
        end

      end
    end
  end
end
