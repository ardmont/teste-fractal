require 'faker'

puts 'Populando banco'

# Cria 100 gêneros
genres = []
(1..100).each do |i| 
  genres << { name: Faker::Music.genre }
end
puts '(1/4) Inserindo gêneros...'
Genre.create(genres)

# Cria 100 artistas
artists = []
(1..100).each do |i| 
  artists << { name: Faker::Music.band, genre_id: rand(1..100) }
end
puts '(2/4) Inserindo artistas...'
Artist.create(artists)

# Cria 100 músicas
musics = []
(1..100).each do |i| 
  musics << { title: Faker::Lorem.sentence, genre_id: rand(1..100), duration: Faker::Number.number(digits: 3) }
end
puts '(3/4) Inserindo músicas...'
Music.create(musics)


# Cria 100 álbums
albums = []
puts '(3/3) Inserindo álbums...'
(1..100).each do |i|
  album_genre = rand(1..100)
  # Busca por um artista aleatoriamente, priorizando o gênero do álbum
  artist = Artist.where(genre_id: album_genre).order("RANDOM()").limit(1).first || Artist.order("RANDOM()").limit(1).first

  album = Album.new({ title: Faker::Lorem.sentence, genre_id: album_genre, artist_id: artist.id })

  # Busca de 1 a 10 músicas aleatoriamente, priorizando o gênero do álbum
  musics = Music.where(genre_id: album_genre).order("RANDOM()").limit(rand(1..10)) || Artist.order("RANDOM()").limit(rand(1..10))
  album.musics << musics # Associa as músicas ao álbum

  # Salva o álbum e as associações no banco
  album.save
end


puts "FIM"
