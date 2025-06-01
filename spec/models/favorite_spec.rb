require 'rails_helper'

# ①対象のクラス及びRSpecの種類を定義
RSpec.describe Favorite, type: :model do

  # ②バリデーションに関するテストグループ
  describe "バリデーションの検証" do

    # ③テストデータ用のuserとsongを用意
    let(:user) { FactoryBot.create(:user) }
    let(:song) { FactoryBot.create(:song, user: user) }

    # ④基本的に正常に作成できるかのテスト
    it "有効なFavoriteオブジェクトが作成できること" do
      favorite = Favorite.new(user: user, song: song)
      expect(favorite).to be_valid
    end

    # ③「同じuserが同じsongを複数回お気に入りできない」ことのテスト
    context "同じuserが同じsongを2回お気に入りしようとした場合" do
      before do
        # ⑤最初のお気に入りを作成（DBに保存）
        FactoryBot.create(:favorite, user: user, song: song)
      end

      it "バリデーションエラーとなること" do
        duplicate_favorite = Favorite.new(user: user, song: song)
        expect(duplicate_favorite).not_to be_valid
        expect(duplicate_favorite.errors[:user_id]).to include("has already been taken")
      end
    end
  end
end
