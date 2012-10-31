
FactoryGirl.define do
  factory :account, :class => Refinery::Midas::Account do
    sequence(:title) { |n| "refinery#{n}" }
  end
end

