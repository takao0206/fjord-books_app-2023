# frozen_string_literal: true

FactoryBot.define do
  factory :report do
    title { 'RailsでCRUD機能を実装' }
    content { "エラーメッセージの表示に関しては少し手間取りましたが、\nerrors.full_messagesを使うことで解決できました。" }

    trait :alice do
      association :user, factory: :user, name: 'Alice'
      title { 'RailsでAPIの設計を学ぶ' }
      content { "今日はRailsを使ったAPI設計について学びました。\n基本的なCRUD操作ができるようになりました。\n次回は認証機能の実装に挑戦したいと思います。" }
    end

    trait :bob do
      association :user, factory: :user, name: 'Bob'
      title { 'RSpecでのテスト駆動開発' }
      content { "RSpecを使って、テスト駆動開発の基本を学びました。\nまだテストの書き方に不安がありますが、\nテストの重要性はしっかりと理解できました。" }
    end
  end
end
