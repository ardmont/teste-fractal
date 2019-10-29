# README

## Descrição
Este projeto consiste em uma API criada em ruby on rails, que fornece e gerência um banco de artistas, álbums e músicas.

## Relacionamentos entre os recursos da API
* Cada artista pertence a um gênero e possui nenhum ou vários álbums.
* Cada álbum pertence a um artista e a um gênero e possui nenhuma ou várias músicas.
* Cada música pertence a um gênero e possui nenhum ou vários álbums.

## Tecnologias utilizadas
* ruby 2.6
* rvm 1.29
* Rails 6.0

## Bibliotecas utilizadas
* apipie-rails
* database_cleaner
* factory_bot_rails
* faker
* rspec-rails
* shoulda-matchers
* will_paginate

## Utiização
A documentação dos endpoints foi criada com a biblioteca apipie, e pode ser vizualizada acessando [http://localhost:3000](http://localhost:3000)

OBS: Os parâmetros enviados para os endpoints POST e PUT devem estar no formato json, no body da requisição. Exceto pelo parâmetro id, que fará parte da uri da requisição.

## Exemplos de utilização

### Listar todos os álbums
`curl -i -H "Accept: application/json" -X GET http://localhost:3000/api/v1/albums`

### Listar todos os álbums de um gênero
`curl -i -H "Accept: application/json" -X GET http://localhost:3000/api/v1/albums?genre_id=1`

### Buscar um álbum por id
`curl -i -H "Accept: application/json" -X GET http://localhost:3000/api/v1/albums/1`

### Adicionar álbum
`curl -H "Content-Type: application/json" \
  --request POST \
  --data '{"title":"Novo álbum","artist_id":1,"genre_id":1,"add_musics":[1,2,3]}' \
  http://localhost:3000/api/v1/albums`
  
### Editar álbum
`curl -H "Content-Type: application/json" \
  --request PUT \
  --data '{"title":"Novo título do álbum"}' \
  http://localhost:3000/api/v1/albums/1`

### Vincular músicas ao álbum
`curl -H "Content-Type: application/json" \
  --request PUT \
  --data '{"add_musics":[1,2,3]}' \
  http://localhost:3000/api/v1/albums/1`
  
 ### Desvincular músicas ao álbum
`curl -H "Content-Type: application/json" \
  --request PUT \
  --data '{"remove_musics":[1,2,3]}' \
  http://localhost:3000/api/v1/albums/1`
  
 ### Remover álbum
 `curl -i -H "Accept: application/json" -X DELETE http://localhost:3000/api/v1/albums/1`
 
 ## Como testar
 Dentro do diretório do projeto, execute o comando `bundle exec rspec`
