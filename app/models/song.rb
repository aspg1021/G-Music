class Song < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user

  # 入力用の仮想属性（DBに保存されない）
  attr_accessor :youtube_video_url

  # バリデーション前に動画IDを抽出する
  before_validation :extract_youtube_video_id

  private

  def extract_youtube_video_id
    return if youtube_video_url.blank?

    begin
      uri = URI.parse(youtube_video_url)

      if uri.host.include?('youtube.com') && uri.query
        # 例: https://www.youtube.com/watch?v=U0efMNTylX8
        params = Rack::Utils.parse_nested_query(uri.query)
        self.youtube_video_id = params['v']
      elsif uri.host.include?('youtu.be')
        # 例: https://youtu.be/U0efMNTylX8
        self.youtube_video_id = uri.path.split('/')[1]
      end
    rescue URI::InvalidURIError
      errors.add(:youtube_video_url, "が不正なURLです")
    end
  end
end
