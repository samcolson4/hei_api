class AddShowAndTypeToEpisodes < ActiveRecord::Migration[8.0]
  def change
    add_column :episodes, :show, :string
    add_column :episodes, :type, :string
  end
end
