class ChangeFiletypeToMsuFiletype < ActiveRecord::Migration[5.1]
  def change
    remove_column :msu_files, :filetype, :string
    add_reference :msu_files, :msu_filetype, foreign_key: true
  end
end
