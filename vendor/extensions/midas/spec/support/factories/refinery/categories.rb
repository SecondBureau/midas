
FactoryGirl.define do
  factory :category, :class => Refinery::Midas::Category do
    sequence(:title) { |n| "refinery#{n}" }
  end
end

