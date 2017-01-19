FactoryGirl.define do
  factory :user do
    sequence :email { |n| "user_#{n}@email.example" }

    trait :with_battlebots do
      transient do
        battlebots_count 5
      end

      after(:create) do |user, evaluator|
        create_list(:battlebot, evaluator.battlebots_count, user: user)
      end
    end
  end
end
