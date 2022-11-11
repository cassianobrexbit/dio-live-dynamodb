# dio-live-dynamodb
Repositório para o live coding do dia 30/09/2021 sobre o Amazon DynamoDB

### Serviço utilizado
  - Amazon DynamoDB
  - Amazon CLI para execução em linha de comando

### Comandos para execução do experimento:

####Criações (tabela, inserções e index)

- Criar uma tabela

> No linux:

```
aws dynamodb create-table \
    --table-name Music \
    --attribute-definitions \
        AttributeName=Artist,AttributeType=S \
        AttributeName=SongTitle,AttributeType=S \
    --key-schema \
        AttributeName=Artist,KeyType=HASH \
        AttributeName=SongTitle,KeyType=RANGE \
    --provisioned-throughput \
        ReadCapacityUnits=10,WriteCapacityUnits=5
```


> No Windows - é preciso tirar o \, tabulações, quebras de linhas e espaços desnecessários

```
aws dynamodb create-table --table-name Music --attribute-definitions AttributeName=Artist,AttributeType=S AttributeName=SongTitle,AttributeType=S --key-schema AttributeName=Artist,KeyType=HASH AttributeName=SongTitle,KeyType=RANGE --provisioned-throughput ReadCapacityUnits=10,WriteCapacityUnits=5
```

- Inserir um item (com arquivo json - é preciso que você esteja acessando a pasta que contém os arquivos no terminal)

> No Linux:

```
aws dynamodb put-item \
    --table-name Music \
    --item file://itemmusic.json \
```

> No Windows:

```
aws dynamodb put-item --table-name Music --item file://itemmusic.json
```

- Inserir múltiplos itens

> No Linux:

```
aws dynamodb batch-write-item \
    --request-items file://batchmusic.json
```

> No Windows:

```
aws dynamodb batch-write-item --request-items file://batchmusic.json
```

- Criar um index global secundário baseado no título do álbum

> No Linux:
```
aws dynamodb update-table \
    --table-name Music \
    --attribute-definitions AttributeName=AlbumTitle,AttributeType=S \
    --global-secondary-index-updates \
        "[{\"Create\":{\"IndexName\": \"AlbumTitle-index\",\"KeySchema\":[{\"AttributeName\":\"AlbumTitle\",\"KeyType\":\"HASH\"}], \
        \"ProvisionedThroughput\": {\"ReadCapacityUnits\": 10, \"WriteCapacityUnits\": 5      },\"Projection\":{\"ProjectionType\":\"ALL\"}}}]"
```

> No Windows:

```
aws dynamodb update-table --table-name Music --attribute-definitions AttributeName=AlbumTitle,AttributeType=S --global-secondary-index-updates "[{\"Create\":{\"IndexName\":\"AlbumTitle-index\",\"KeySchema\":[{\"AttributeName\":\"AlbumTitle\",\"KeyType\":\"HASH\"}],\"ProvisionedThroughput\":{\"ReadCapacityUnits\":10,\"WriteCapacityUnits\":5},\"Projection\":{\"ProjectionType\":\"ALL\"}}}]"
```

- Criar um index global secundário baseado no nome do artista e no título do álbum

> No Linux:

```
aws dynamodb update-table \
    --table-name Music \
    --attribute-definitions\
        AttributeName=Artist,AttributeType=S \
        AttributeName=AlbumTitle,AttributeType=S \
    --global-secondary-index-updates \
        "[{\"Create\":{\"IndexName\": \"ArtistAlbumTitle-index\",\"KeySchema\":[{\"AttributeName\":\"Artist\",\"KeyType\":\"HASH\"}, {\"AttributeName\":\"AlbumTitle\",\"KeyType\":\"RANGE\"}], \
        \"ProvisionedThroughput\": {\"ReadCapacityUnits\": 10, \"WriteCapacityUnits\": 5      },\"Projection\":{\"ProjectionType\":\"ALL\"}}}]"
```

> No Windows:

```
aws dynamodb update-table --table-name Music --attribute-definitions AttributeName=Artist,AttributeType=S AttributeName=AlbumTitle,AttributeType=S --global-secondary-index-updates "[{\"Create\":{\"IndexName\": \"ArtistAlbumTitle-index\",\"KeySchema\":[{\"AttributeName\":\"Artist\",\"KeyType\":\"HASH\"},{\"AttributeName\":\"AlbumTitle\",\"KeyType\":\"RANGE\"}],\"ProvisionedThroughput\":{\"ReadCapacityUnits\": 10, \"WriteCapacityUnits\":5},\"Projection\":{\"ProjectionType\":\"ALL\"}}}]"

```

- Criar um index global secundário baseado no título da música e no ano


> No Linux:

```
aws dynamodb update-table \
    --table-name Music \
    --attribute-definitions\
        AttributeName=SongTitle,AttributeType=S \
        AttributeName=SongYear,AttributeType=S \
    --global-secondary-index-updates \
        "[{\"Create\":{\"IndexName\": \"SongTitleYear-index\",\"KeySchema\":[{\"AttributeName\":\"SongTitle\",\"KeyType\":\"HASH\"}, {\"AttributeName\":\"SongYear\",\"KeyType\":\"RANGE\"}], \
        \"ProvisionedThroughput\": {\"ReadCapacityUnits\": 10, \"WriteCapacityUnits\": 5      },\"Projection\":{\"ProjectionType\":\"ALL\"}}}]"
```

> No Windows:

```
aws dynamodb update-table --table-name Music --attribute-definitions AttributeName=SongTitle,AttributeType=S AttributeName=SongYear,AttributeType=S --global-secondary-index-updates "[{\"Create\":{\"IndexName\": \"SongTitleYear-index\",\"KeySchema\":[{\"AttributeName\":\"SongTitle\",\"KeyType\":\"HASH\"},{\"AttributeName\":\"SongYear\",\"KeyType\":\"RANGE\"}],\"ProvisionedThroughput\":{\"ReadCapacityUnits\":10, \"WriteCapacityUnits\": 5},\"Projection\":{\"ProjectionType\":\"ALL\"}}}]"
```

#### Consultas

- Pesquisar item por artista

> No Linux:

```
aws dynamodb query \
    --table-name Music \
    --key-condition-expression "Artist = :artist" \
    --expression-attribute-values  '{":artist":{"S":"Iron Maiden"}}'
```

> No Windows:

```
aws dynamodb query --table-name Music --key-condition-expression "Artist=:artist" --expression-attribute-values "{\":artist\":{\"S\":\"Iron Maiden\"}}"
```

- Pesquisa por nome da música

> No Windows*: 

```
aws dynamodb query --table-name Music --key-condition-expression "SongTitle=:title" --expression-attribute-values "{\":title\":{\"S\":\"Fear of the Dark\"}}"
```

> Dá erro, pois para pesquisar precisamos atribuir a Partition key e não APENAS a Sorted key. 
    > É possível pesquisar só com a Partition Key.
        >Para encontrar um elemento sem a composição da primary key é importante cadastrar uma secondary key. 

- Pesquisar item por artista e título da música

> No Linux:

```
aws dynamodb query \
    --table-name Music \
    --key-condition-expression "Artist = :artist and SongTitle = :title" \
    --expression-attribute-values file://keyconditions.json
```

> No Windows:

```
aws dynamodb query --table-name Music --key-condition-expression "Artist = :artist and SongTitle = :title" --expression-attribute-values file://keyconditions.json
```

- Pesquisa pelo index secundário baseado no título do álbum

> No Linux:

```
aws dynamodb query \
    --table-name Music \
    --index-name AlbumTitle-index \
    --key-condition-expression "AlbumTitle = :name" \
    --expression-attribute-values  '{":name":{"S":"Fear of the Dark"}}'
```

> No Windows:

```
aws dynamodb query --table-name Music --index-name AlbumTitle-index --key-condition-expression "AlbumTitle = :name" --expression-attribute-values "{\":name\":{\"S\":\"Fear of the Dark\"}}"
```

- Pesquisa pelo index secundário baseado no nome do artista e no título do álbum

> No Linux:

```
aws dynamodb query \
    --table-name Music \
    --index-name ArtistAlbumTitle-index \
    --key-condition-expression "Artist = :v_artist and AlbumTitle = :v_title" \
    --expression-attribute-values  '{":v_artist":{"S":"Iron Maiden"},":v_title":{"S":"Fear of the Dark"} }'
```

> No Windows:

```
aws dynamodb query --table-name Music --index-name ArtistAlbumTitle-index --key-condition-expression "Artist = :v_artist and AlbumTitle = :v_title" --expression-attribute-values "{\":v_artist\":{\"S\":\"Iron Maiden\"},\":v_title\":{\"S\":\"Fear of the Dark\"}}"
```

- Pesquisa pelo index secundário baseado no título da música e no ano

> No Linux:

```
aws dynamodb query \
    --table-name Music \
    --index-name SongTitleYear-index \
    --key-condition-expression "SongTitle = :v_song and SongYear = :v_year" \
    --expression-attribute-values  '{":v_song":{"S":"Wasting Love"},":v_year":{"S":"1992"} }'
```

> No Windows:

```
aws dynamodb query --table-name Music --index-name SongTitleYear-index --key-condition-expression "SongTitle = :v_song and SongYear = :v_year" --expression-attribute-values "{\":v_song\":{\"S\":\"Wasting Love\"},\":v_year\":{\"S\":\"1992\"}}"
```