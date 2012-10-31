require 'spec_helper'

module Refinery
  module Midas
    describe Entry do
      describe "validations" do
        subject do
          FactoryGirl.create(:entry,
          :currency => "Refinery CMS")
        end

        it { should be_valid }
        its(:errors) { should be_empty }
        its(:currency) { should == "Refinery CMS" }
      end
    end
  end
end
