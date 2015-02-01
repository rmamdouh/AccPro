FactoryGirl.define do
  factory :user do
    email "admin@admin.com"
    password "12345678"
    password_confirmation "12345678"
    admin true   
  end

end
