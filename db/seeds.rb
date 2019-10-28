require 'faker'

puts 'Populando banco'

# Cria 50 artistas
artists = []
(1..50).each do |i| 
  artists << { name: Faker::Music.band, genre: Faker::Music.genre }
end
puts '(1/3) Inserindo artistas...'
Artist.create(artists)

# Cria 300 músicas
musics = []
(1..300).each do |i| 
  musics << { title: Faker::Lorem.sentence, genre: Faker::Music.genre, duration: Faker::Number.number(digits: 3) }
end
puts '(2/3) Inserindo músicas...'
Music.create(musics)

# Cria 180 álbums
albums = []
puts '(3/3) Inserindo álbums...'
(1..180).each do |i|
  album_genre = Faker::Music.genre
  # Busca por um artista aleatoriamente, priorizando o gênero do álbum
  artist = Artist.where(genre: album_genre).order("RANDOM()").limit(1).first || Artist.order("RANDOM()").limit(1).first

  album = Album.new({ title: Faker::Lorem.sentence, genre: album_genre, artist_id: artist.id })

  # Busca de 1 a 10 músicas aleatoriamente, priorizando o gênero do álbum
  musics = Music.where(genre: album_genre).order("RANDOM()").limit(rand(1..10)) || Artist.order("RANDOM()").limit(rand(1..10))
  album.musics << musics # Associa as músicas ao álbum

  # Salva o álbum e as associações no banco
  album.save
end

puts "FIM"