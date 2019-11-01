class AddFavoriteToAlbum < ActiveRecord::Migration[6.0]
  def change
    add_column :albums, :favorite, :boolean
  end
end
