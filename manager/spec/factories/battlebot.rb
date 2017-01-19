FactoryGirl.define do
  factory :battlebot do
    sequence :name { |n| "Battlebot ##{n}" }

    trait :with_user do
      user
    end
  end
end
