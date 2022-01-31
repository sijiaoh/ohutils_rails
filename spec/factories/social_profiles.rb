FactoryBot.define do
  factory :social_profile do
    transient do
      google { Faker::Omniauth.unique.google }
    end

    provider { google[:provider] }
    uid { google[:uid] }
    email { google[:info][:email] }
    user
  end
end
