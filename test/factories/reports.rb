# frozen_string_literal: true

FactoryBot.define do
  factory :report do
    title { 'Test report' }
    content { 'Test report content' }
  end
end
