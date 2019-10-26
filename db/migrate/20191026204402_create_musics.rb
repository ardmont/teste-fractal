class CreateMusics < ActiveRecord::Migration[6.0]
  def change
    create_table :musics do |t|
      t.string :title
      t.integer :duration
      t.string :genre

      t.timestamps
    end
  end
end
