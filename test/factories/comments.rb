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
  end
end
