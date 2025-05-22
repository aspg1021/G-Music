class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :song

  validates :user_id, uniqueness: { scope: :song_id }  # 同じ曲を2回お気に入りできないように
end
