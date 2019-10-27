class CreateJoinTableAlbumMusic < ActiveRecord::Migration[6.0]
  def change
    create_join_table :albums, :musics do |t|
      # t.index [:album_id, :music_id]
      # t.index [:music_id, :album_id]
    end
  end
end
