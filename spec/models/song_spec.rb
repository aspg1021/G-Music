require 'rails_helper'

# ①対象のクラス及びRSpecの種類を定義
RSpec.describe Song, type: :model do

  # ②対象のメソッドや機能を記載
  describe "youtube_video_urlのバリデーションと動画ID抽出" do

    # 事前にuserを作成（Songはuserに属するため必須）
    let(:user) { FactoryBot.create(:user) }

    # ③テストの条件を記載（youtube_video_urlが空の場合）
    context "youtube_video_urlが空の場合" do

      # ⑤テストデータを作成しsong変数に入れる
      let(:song) { Song.new(user: user, youtube_video_url: "") }

      # ④期待する実行結果を記載
      it "エラーが発生すること" do

        # ⑥テストの実行結果を検証
        song.valid?  # バリデーションを実行
        expect(song.errors[:youtube_video_url]).to include("を入力してください")
      end
    end

    # ③テストの条件を記載（正しいyoutube.comのURLの場合）
    context "正しいyoutube.comのURLの場合" do

      # ⑤テストデータを作成しsong変数に入れる
      let(:song) do
        Song.new(user: user, youtube_video_url: "https://www.youtube.com/watch?v=U0efMNTylX8")
      end

      # ④期待する実行結果を記載
      it "動画IDが正しく抽出されること" do

        # ⑥テストの実行結果を検証
        song.valid?
        expect(song.youtube_video_id).to eq("U0efMNTylX8")
        expect(song.errors[:youtube_video_url]).to be_empty
      end
    end

    # ③テストの条件を記載（正しいyoutu.beのURLの場合）
    context "正しいyoutu.beのURLの場合" do

      # ⑤テストデータを作成しsong変数に入れる
      let(:song) do
        Song.new(user: user, youtube_video_url: "https://youtu.be/U0efMNTylX8")
      end

      # ④期待する実行結果を記載
      it "動画IDが正しく抽出されること" do

        # ⑥テストの実行結果を検証
        song.valid?
        expect(song.youtube_video_id).to eq("U0efMNTylX8")
        expect(song.errors[:youtube_video_url]).to be_empty
      end
    end

    # ③テストの条件を記載（YouTube以外のURLの場合）
    context "YouTube以外のURLの場合" do

      # ⑤テストデータを作成しsong変数に入れる
      let(:song) do
        Song.new(user: user, youtube_video_url: "https://example.com/watch?v=xxxx")
      end

      # ④期待する実行結果を記載
      it "エラーが発生すること" do

        # ⑥テストの実行結果を検証
        song.valid?
        expect(song.errors[:youtube_video_url]).to include("がYouTubeのURLではありません")
      end
    end

    # ③テストの条件を記載（不正なURLの場合）
    context "不正なURLの場合" do

      # ⑤テストデータを作成しsong変数に入れる
      let(:song) do
        Song.new(user: user, youtube_video_url: "ht!tp://invalid-url")
      end

      # ④期待する実行結果を記載
      it "エラーが発生すること" do

        # ⑥テストの実行結果を検証
        song.valid?
        expect(song.errors[:youtube_video_url]).to include("が不正なURLです")
      end
    end
  end
end
