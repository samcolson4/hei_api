require "test_helper"

class Api::V1::EpisodesControllerTest < ActionDispatch::IntegrationTest
  test "#index - lists episodes in descending order based on aired_at" do
    episode1 = Episode.create!(episode_title: "Episode 1", aired_at: 2.days.ago)
    episode2 = Episode.create!(episode_title: "Episode 2", aired_at: 1.day.ago)
    episode3 = Episode.create!(episode_title: "Episode 3", aired_at: 3.days.ago)

    get api_v1_episodes_path
    assert_response :success

    response_body = JSON.parse(response.body)
    aired_dates = response_body['data'].map { |episode| episode['attributes']['aired_at'] }

    assert_equal aired_dates, aired_dates.sort.reverse
  end
end
