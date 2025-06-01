require 'rails_helper'

# ① テストタイプをSystem Specとして定義
RSpec.describe "楽曲登録機能", type: :system do

  # ② テスト用ユーザーをFactoryBotで作成（ログインに使用）
  let!(:user) { FactoryBot.create(:user) }

  # ③ 正常系：正しい情報で楽曲登録できることをテスト
  context "正しい情報を入力した場合" do

    # ④ 楽曲登録成功のテスト
    it "楽曲を新規登録し、登録完了メッセージが表示されること" do

      # ⑤ ログイン処理（多くの場合テストヘルパーで省略可能）
      visit new_user_session_path
      fill_in "メールアドレス", with: user.email
      fill_in "パスワード", with: user.password
      click_button "ログイン"

      # ⑥ 楽曲登録ページへ遷移
      visit new_song_path

      # ⑦ フォームに楽曲情報を入力
      fill_in "YouTubeのURL", with: "https://www.youtube.com/watch?v=XXXXXXX"
      fill_in "タイトル", with: "テスト楽曲タイトル"
      fill_in "チャンネル名", with: "テストアーティスト"

      # ⑧ 「登録」ボタンをクリック
      click_button "登録"

      # ⑨ 登録成功メッセージと遷移先を検証
      expect(page).to have_content("楽曲を登録しました")
      expect(current_path).to eq songs_path  # 楽曲一覧ページへ遷移している想定
    end

    # ⑩ 登録した楽曲がトップページに表示されることを確認
    it "登録後、トップページに登録した楽曲が表示されていること" do

      # ログインして楽曲を登録（前のテストとほぼ同じ手順）
      visit new_user_session_path
      fill_in "メールアドレス", with: user.email
      fill_in "パスワード", with: user.password
      click_button "ログイン"

      visit new_song_path
      fill_in "YouTubeのURL", with: "https://www.youtube.com/watch?v=YYYYYYY"
      fill_in "タイトル", with: "トップページ表示確認用楽曲"
      fill_in "チャンネル名", with: "テストアーティスト"
      click_button "登録"

      # トップページへ遷移
      visit root_path

      # トップページに登録した楽曲のタイトルが表示されているか検証
      expect(page).to have_content("トップページ表示確認用楽曲")
      # 必要ならアーティスト名なども検証可能
      expect(page).to have_content("テストアーティスト")
    end
  end

  # ③ 異常系：必要情報が不足している場合のテスト
  context "必要な情報が不足している場合" do

    # ④ 楽曲登録失敗のテスト
    it "エラーメッセージが表示され、登録できないこと" do

      # ⑤ ログイン処理
      visit new_user_session_path
      fill_in "メールアドレス", with: user.email
      fill_in "パスワード", with: user.password
      click_button "ログイン"

      # ⑥ 楽曲登録ページへ遷移
      visit new_song_path

      # ⑦ フォームを空のまま送信
      click_button "登録"

      # ⑧ エラーメッセージを検証
      expect(page).to have_content("YouTubeのURLを入力してください")

      # ⑨ 登録ページに留まっていることを確認
      expect(current_path).to eq songs_path # バリデーション失敗後は通常再表示される
    end
  end
end
