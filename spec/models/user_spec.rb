require 'rails_helper'

# ①対象のクラス及びRSpecの種類を定義
RSpec.describe User, type: :model do

  # ②対象のメソッドを記載
  describe "#display_icon_image" do

    # ③テストの条件を記載（アイコン画像が添付されている場合）
    context "icon_imageが添付されている場合" do

      # ⑤テストデータを作成しuser変数に入れる
      let!(:user) do
        user = FactoryBot.create(:user)
        user.icon_image.attach(
          io: File.open(Rails.root.join('spec/fixtures/files/sample-icon.png')),
          filename: 'sample-icon.png',
          content_type: 'image/png'
        )
        user
      end

      # ④期待する実行結果を記載
      it "添付されたicon_imageオブジェクトを返すこと" do

        # ⑥テストの実行結果を検証
        expect(user.display_icon_image).to be_an_instance_of(ActiveStorage::Attached::One)
      end
    end

    # ③テストの条件を記載（アイコン画像が添付されていない場合）
    context "icon_imageが添付されていない場合" do

      # ⑤テストデータを作成しuser変数に入れる
      let!(:user) { FactoryBot.build(:user) }

      # ④期待する実行結果を記載
      it "デフォルト画像のパスを返すこと" do

        # ⑥テストの実行結果を検証
        expect(user.display_icon_image).to eq("default-icon.png")
      end
    end
  end
end
