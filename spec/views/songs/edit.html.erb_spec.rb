require 'rails_helper'

RSpec.describe "songs/edit", type: :view do
  let(:song) {
    Song.create!(
      title: "MyString",
      youtube_video_id: "MyString",
      channel_name: "MyString",
      user: nil
    )
  }

  before(:each) do
    assign(:song, song)
  end

  it "renders the edit song form" do
    render

    assert_select "form[action=?][method=?]", song_path(song), "post" do

      assert_select "input[name=?]", "song[title]"

      assert_select "input[name=?]", "song[youtube_video_id]"

      assert_select "input[name=?]", "song[channel_name]"

      assert_select "input[name=?]", "song[user_id]"
    end
  end
end
