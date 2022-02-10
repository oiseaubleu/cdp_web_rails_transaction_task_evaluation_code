FactoryBot.define do
  factory :user do
    name { 'ユーザ１' }
    email { 'user1@gmail.com' }
    password { 'password' }
    password_confirmation { 'password' }
  end

  factory :second_user, class: User do
    name { 'ユーザ２' }
    email { 'user2@gmail.com' }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
