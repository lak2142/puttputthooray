FactoryGirl.define do
  factory :team do
    sequence :team_name do |n|
      "Fierce Nails #{n}"
    end
    college
  end
end
