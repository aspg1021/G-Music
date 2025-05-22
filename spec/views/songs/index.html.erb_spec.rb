require 'rails_helper'

RSpec.describe "songs/index", type: :view do
  before(:each) do
    assign(:songs, [
      Song.create!(
        title: "Title",
        youtube_video_id: "Youtube Video",
        channel_name: "Channel Name",
        user: nil
      ),
      Song.create!(
        title: "Title",
        youtube_video_id: "Youtube Video",
        channel_name: "Channel Name",
        user: nil
      )
    ])
  end

  it "renders a list of songs" do
    render
    cell_selector = 'tr>td'
    assert_select cell_selector, text: Regexp.new("Title".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Youtube Video".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Channel Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
  end
end
