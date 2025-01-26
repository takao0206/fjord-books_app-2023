# frozen_string_literal: true

FactoryBot.define do
  factory :report_mention do
    association :mentioning, factory: :user, trait: :bob
    association :mentioned, factory: :user, trait: :alice
  end
end
