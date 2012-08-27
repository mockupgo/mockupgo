FactoryGirl.define do
  factory :user do
    email 'example@example.com'
    password '314159'
    password_confirmation '314159'
    # required if the Devise Confirmable module is used
    # confirmed_at Time.now
  end
end