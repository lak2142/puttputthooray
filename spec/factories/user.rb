FactoryGirl.define do
  factory :user do
    email 'john@watson.com'
    password 'password'

    factory :admin do |admin|
      admin.after(:create) do |a|
        a.add_role(:admin)
      end
    end
  end
end
