require 'rails_helper'

RSpec.describe "songs/show", type: :view do
  before(:each) do
    assign(:song, Song.create!(
      title: "Title",
      youtube_video_id: "Youtube Video",
      channel_name: "Channel Name",
      user: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Youtube Video/)
    expect(rendered).to match(/Channel Name/)
    expect(rendered).to match(//)
  end
end
