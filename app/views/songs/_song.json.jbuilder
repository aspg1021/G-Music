json.extract! song, :id, :title, :youtube_video_id, :channel_name, :user_id, :created_at, :updated_at
json.url song_url(song, format: :json)
