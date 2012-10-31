
FactoryGirl.define do
  factory :entry, :class => Refinery::Midas::Entry do
    sequence(:currency) { |n| "refinery#{n}" }
  end
end

