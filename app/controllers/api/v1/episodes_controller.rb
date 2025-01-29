module Api
  module V1
    class EpisodesController < ApplicationController
      def index
        episodes = Episode.order(aired_at: :desc)
        render json: EpisodeSerializer.new(episodes).serializable_hash
      end
    end
  end
end
