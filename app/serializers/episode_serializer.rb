class EpisodeSerializer
  include JSONAPI::Serializer
  set_type :episode
  attributes :episode_url, :collection, :episode_title, :poster_url, :aired_at, :show, :media_type, :created_at, :updated_at
end
