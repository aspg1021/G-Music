require 'rails_helper'

RSpec.describe "songs/new", type: :view do
  before(:each) do
    assign(:song, Song.new(
      title: "MyString",
      youtube_video_id: "MyString",
      channel_name: "MyString",
      user: nil
    ))
  end

  it "renders new song form" do
    render

    assert_select "form[action=?][method=?]", songs_path, "post" do

      assert_select "input[name=?]", "song[title]"

      assert_select "input[name=?]", "song[youtube_video_id]"

      assert_select "input[name=?]", "song[channel_name]"

      assert_select "input[name=?]", "song[user_id]"
    end
  end
end
