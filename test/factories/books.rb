# frozen_string_literal: true

FactoryBot.define do
  factory :book do
    title { 'リンゴの秘密' }
    memo { "世界中のリンゴの品種と\nその歴史を紹介した一冊。" }
  end
end
