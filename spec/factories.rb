FactoryGirl.define do
  factory :user do
    name     "Engin Sozer"
    email    "enginsozer@gmail.com"
    password "foobar"
    password_confirmation "foobar"
  end
end