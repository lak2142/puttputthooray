FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "john#{n}@watson.com" }
    password 'password'

    factory :admin do |admin|
      admin.after(:create) do |a|
        a.add_role(:admin)
      end
    end

  end
  factory :user_profile do
    first_name 'john'
    last_name 'watson'
    birthdate Time.now
    university 'Bentley'
    gender 'Male'
    graduation_year 2006
    hometown 'Portland'
    major 'Finance'
    phone '1234567891'
    user
  end
end
