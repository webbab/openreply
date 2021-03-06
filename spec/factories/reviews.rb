# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :review do
    text { Faker::Lorem.paragraphs(rand(2..8)).join('\n') }
    ignored_rating {true}
    rating {create :rating}
  end
end
