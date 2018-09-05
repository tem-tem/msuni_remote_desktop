class CreateMsuFiletypes < ActiveRecord::Migration[5.1]
  def change
    create_table :msu_filetypes do |t|
      t.string :name
      t.timestamps
    end
  end
end
