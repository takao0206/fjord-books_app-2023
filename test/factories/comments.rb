# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    content do
      <<~TEXT
        日報の共有ありがとうございます。
        私も似たような課題に直面しているので、
        進め方や工夫された点について非常に参考になりました。
      TEXT
    end

    trait :alice do
      content { "日報の共有、ありがとうございます。\nもし具体的な方法があれば教えていただけると嬉しいです。" }
      association :user, factory: :user, name: 'alice'
      association :commentable, factory: :commentable
      commentable_type { 'Commentable' }
    end
  end
end
