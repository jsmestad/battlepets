FactoryGirl.define do
  factory :user do
    sequence :email { |n| "user_#{n}@email.example" }
  end
end
