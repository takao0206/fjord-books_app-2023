# frozen_string_literal: true

FactoryBot.define do
  factory :report do
    title { 'RailsでCRUD機能を実装' }
    content do
      <<~TEXT
        エラーメッセージの表示に関しては少し手間取りましたが、
        errors.full_messagesを使うことで解決できました。
      TEXT
    end
  end
end
