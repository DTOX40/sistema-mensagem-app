FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { password }
    name { Faker::Name.name }
    uid { email }
    provider { 'email' }
    role { :Regular }
    status { :Active }

    trait :admin do
      role { :Admin }
    end

    trait :suspended do
      status { :Suspended }
    end
  end
end
