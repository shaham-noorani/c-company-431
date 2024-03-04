FactoryBot.define do
    factory :user do
      first_name { "Test" }
      last_name { "User" }
      email { "test@example.com" }
      role { "admin" }
    end
  end