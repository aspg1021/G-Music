class User < ApplicationRecord
  # Deviseの設定
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :songs
  has_many :favorites
  has_many :favorite_songs, through: :favorites, source: :song

  has_one_attached :icon_image
  
  def display_icon_image
    icon_image.attached? ? icon_image : "default-icon.png"
  end
end
