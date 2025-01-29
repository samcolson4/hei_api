class CreateEpisodes < ActiveRecord::Migration[8.0]
  def change
    create_table :episodes do |t|
      t.string :episode_url
      t.string :collection
      t.string :episode_title
      t.string :poster_url
      t.datetime :aired_at

      t.timestamps
    end
  end
end
