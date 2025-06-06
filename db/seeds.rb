# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.find_or_create_by!(email: "test@example.com") do |u|
  u.password = "password"
end

Song.create!(
  [
    {
      title: "Daisy Crown",
      youtube_video_url: "https://www.youtube.com/watch?v=yHCWtVMqoig",
      channel_name: "Empty old City",
      user: user
    },
    {
      title: "Life Will Change",
      youtube_video_url: "https://www.youtube.com/watch?v=dsuJZx24V_A",
      channel_name: "Lyn",
      user: user
    }
  ]
)
