# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    password { 'password' }

    trait :carol do
      name { 'Carol' }
      email { 'carol@example.com' }

      after(:build) do |user|
        user.avatar.attach(
          io: File.open(Rails.root.join('test/fixtures/files/avatar.jpeg')),
          filename: 'avatar.jpeg',
          content_type: 'image/jpeg'
        )
      end
    end

    trait :dave do
      name { 'Dave' }
      email { 'dave@example.com' }
    end
  end
end
