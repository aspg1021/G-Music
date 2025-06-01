FactoryBot.define do
  factory :song do
    title { "MyString" }
    channel_name { "MyString" }
    association :user   # userを関連付ける

    # 仮想属性用の一時変数を定義（テストでyoutube_video_urlを渡せるように）
    transient do
      youtube_video_url_value { "https://www.youtube.com/watch?v=dQw4w9WgXcQ" }
    end

    after(:build) do |song, evaluator|
      song.youtube_video_url = evaluator.youtube_video_url_value  # 仮想属性にセット
      song.validate  # before_validation コールバックを実行しyoutube_video_idをセット
    end
  end
end
