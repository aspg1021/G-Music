FactoryBot.define do
  factory :user do
    # 必須カラムのサンプル値（ユニークなemailが必要なのでsequenceで連番）
    sequence(:email) { |n| "testuser#{n}@example.com" }
    password { "password123" }
    password_confirmation { "password123" }
  end
end
