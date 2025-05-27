require 'rails_helper'

# ① 対象のテストタイプを定義（System Spec）
RSpec.describe "ユーザーのログイン機能", type: :system do

  # ② テスト用ユーザーをFactoryBotで作成
  let!(:user) { FactoryBot.create(:user, email: "test@example.com", password: "password", password_confirmation: "password") }

  # ③ 正常系：正しい情報でログインできることをテスト
  context "正しい情報を入力した場合" do

    # ④ 実際のブラウザ操作を再現するテスト
    it "ログインに成功し、トップページにリダイレクトされること" do

      # ⑤ ログインページへ遷移
      visit new_user_session_path

      # ⑥ フォームにメールアドレスとパスワードを入力
      fill_in "メールアドレス", with: "test@example.com"
      fill_in "パスワード", with: "password"

      # ⑦ 「ログイン」ボタンをクリック
      click_button "ログイン"

      # ⑧ 成功メッセージと遷移先を検証
      expect(page).to have_content("ログインしました")        # フラッシュメッセージ（日本語化されている前提）
      expect(current_path).to eq root_path                     # ログイン後にトップページへ遷移
    end
  end

  # ③ 異常系：間違った情報でログインに失敗することをテスト
  context "誤った情報を入力した場合" do

    # ④ ログイン失敗のテスト
    it "ログインに失敗し、エラーメッセージが表示されること" do

      # ⑤ ログインページへ遷移
      visit new_user_session_path

      # ⑥ 間違ったメールアドレスとパスワードを入力
      fill_in "メールアドレス", with: "wrong@example.com"
      fill_in "パスワード", with: "wrongpassword"

      # ⑦ 「ログイン」ボタンをクリック
      click_button "ログイン"

      # ⑧ エラーメッセージとリダイレクト先を検証
      expect(page).to have_content("メールアドレスまたはパスワードが違います。") # Deviseのデフォルトメッセージ（日本語化）
      expect(current_path).to eq new_user_session_path                             # 失敗時は再度ログインページにとどまる
    end
  end
end
