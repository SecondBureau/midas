# encoding: utf-8
require "spec_helper"

describe Refinery do
  describe "Midas" do
    describe "Admin" do
      describe "categories" do
        login_refinery_user

        describe "categories list" do
          before do
            FactoryGirl.create(:category, :title => "UniqueTitleOne")
            FactoryGirl.create(:category, :title => "UniqueTitleTwo")
          end

          it "shows two items" do
            visit refinery.midas_admin_categories_path
            page.should have_content("UniqueTitleOne")
            page.should have_content("UniqueTitleTwo")
          end
        end

        describe "create" do
          before do
            visit refinery.midas_admin_categories_path

            click_link "Add New Category"
          end

          context "valid data" do
            it "should succeed" do
              fill_in "Title", :with => "This is a test of the first string field"
              click_button "Save"

              page.should have_content("'This is a test of the first string field' was successfully added.")
              Refinery::Midas::Category.count.should == 1
            end
          end

          context "invalid data" do
            it "should fail" do
              click_button "Save"

              page.should have_content("Title can't be blank")
              Refinery::Midas::Category.count.should == 0
            end
          end

          context "duplicate" do
            before { FactoryGirl.create(:category, :title => "UniqueTitle") }

            it "should fail" do
              visit refinery.midas_admin_categories_path

              click_link "Add New Category"

              fill_in "Title", :with => "UniqueTitle"
              click_button "Save"

              page.should have_content("There were problems")
              Refinery::Midas::Category.count.should == 1
            end
          end

          context "with translations" do
            before do
              Refinery::I18n.stub(:frontend_locales).and_return([:en, :cs])
            end

            describe "add a page with title for default locale" do
              before do
                visit refinery.midas_admin_categories_path
                click_link "Add New Category"
                fill_in "Title", :with => "First column"
                click_button "Save"
              end

              it "should succeed" do
                Refinery::Midas::Category.count.should == 1
              end

              it "should show locale flag for page" do
                p = Refinery::Midas::Category.last
                within "#category_#{p.id}" do
                  page.should have_css("img[src='/assets/refinery/icons/flags/en.png']")
                end
              end

              it "should show title in the admin menu" do
                p = Refinery::Midas::Category.last
                within "#category_#{p.id}" do
                  page.should have_content('First column')
                end
              end
            end

            describe "add a category with title for primary and secondary locale" do
              before do
                visit refinery.midas_admin_categories_path
                click_link "Add New Category"
                fill_in "Title", :with => "First column"
                click_button "Save"

                visit refinery.midas_admin_categories_path
                within ".actions" do
                  click_link "Edit this category"
                end
                within "#switch_locale_picker" do
                  click_link "Cs"
                end
                fill_in "Title", :with => "First translated column"
                click_button "Save"
              end

              it "should succeed" do
                Refinery::Midas::Category.count.should == 1
                Refinery::Midas::Category::Translation.count.should == 2
              end

              it "should show locale flag for page" do
                p = Refinery::Midas::Category.last
                within "#category_#{p.id}" do
                  page.should have_css("img[src='/assets/refinery/icons/flags/en.png']")
                  page.should have_css("img[src='/assets/refinery/icons/flags/cs.png']")
                end
              end

              it "should show title in backend locale in the admin menu" do
                p = Refinery::Midas::Category.last
                within "#category_#{p.id}" do
                  page.should have_content('First column')
                end
              end
            end

            describe "add a title with title only for secondary locale" do
              before do
                visit refinery.midas_admin_categories_path
                click_link "Add New Category"
                within "#switch_locale_picker" do
                  click_link "Cs"
                end

                fill_in "Title", :with => "First translated column"
                click_button "Save"
              end

              it "should show title in backend locale in the admin menu" do
                p = Refinery::Midas::Category.last
                within "#category_#{p.id}" do
                  page.should have_content('First translated column')
                end
              end

              it "should show locale flag for page" do
                p = Refinery::Midas::Category.last
                within "#category_#{p.id}" do
                  page.should have_css("img[src='/assets/refinery/icons/flags/cs.png']")
                end
              end
            end
          end

        end

        describe "edit" do
          before { FactoryGirl.create(:category, :title => "A title") }

          it "should succeed" do
            visit refinery.midas_admin_categories_path

            within ".actions" do
              click_link "Edit this category"
            end

            fill_in "Title", :with => "A different title"
            click_button "Save"

            page.should have_content("'A different title' was successfully updated.")
            page.should have_no_content("A title")
          end
        end

        describe "destroy" do
          before { FactoryGirl.create(:category, :title => "UniqueTitleOne") }

          it "should succeed" do
            visit refinery.midas_admin_categories_path

            click_link "Remove this category forever"

            page.should have_content("'UniqueTitleOne' was successfully removed.")
            Refinery::Midas::Category.count.should == 0
          end
        end

      end
    end
  end
end
