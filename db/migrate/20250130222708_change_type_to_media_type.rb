class ChangeTypeToMediaType < ActiveRecord::Migration[8.0]
  def change
    rename_column :episodes, :type, :media_type
  end
end
