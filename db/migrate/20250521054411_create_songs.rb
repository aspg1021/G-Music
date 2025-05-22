class CreateSongs < ActiveRecord::Migration[6.1]
  def change
    create_table :songs do |t|
      t.string :title
      t.string :youtube_video_id
      t.string :channel_name
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
