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

  test "#index - episodes have correct attributes" do
    episode1 = Episode.create!(episode_title: "Episode 1", aired_at: 2.days.ago, show: 'Decker', media_type: 'episode', episode_url: 'www.test.com', collection: 'Season 1', poster_url: 'www.poster.com')

    get api_v1_episodes_path
    assert_response :success

    response_body = JSON.parse(response.body)
    attributes = response_body['data'].first['attributes']

    assert attributes.key?('episode_url')
    assert attributes.key?('collection')
    assert attributes.key?('episode_title')
    assert attributes.key?('poster_url')
    assert attributes.key?('aired_at')
    assert attributes.key?('show')
    assert attributes.key?('media_type')
  end
end
