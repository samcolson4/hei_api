# Usage:
# rake db:generate_seeds JSON_FILE=path/to/episodes.json

namespace :db do
  desc "Generate seeds.rb from a JSON file"
  task generate_seeds: :environment do
    json_file = ENV['JSON_FILE']

    unless json_file && File.exist?(json_file)
      puts "Usage: rake db:generate_seeds JSON_FILE=path/to/episodes.json"
      exit 1
    end

    json_content = File.read(json_file).strip

    File.write('db/seeds.rb', <<~RUBY)
      require 'json'

      episodes_json = <<-JSON
      #{json_content}
      JSON

      episodes = JSON.parse(episodes_json)

      episodes.each do |episode|
        Episode.find_or_create_by!(episode_url: episode["episode_url"]) do |e|
          e.collection = episode["collection"]
          e.episode_title = episode["episode_title"]
          e.poster_url = episode["poster_url"]
          e.aired_at = episode["aired_at"]
        end
      end

      puts "Seeded \#{episodes.size} episodes."
    RUBY

    puts "✅ db/seeds.rb has been generated successfully!"
  end
end
