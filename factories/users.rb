FactoryBot.define do
  factory :user do
    name { 'user1' }
    email { 'user1@gmail.com' }
    password { 'password' }
    password_confirmation { 'password' }
  end

  factory :second_user, class: User do
    name { 'user2' }
    email { 'user2@gmail.com' }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
