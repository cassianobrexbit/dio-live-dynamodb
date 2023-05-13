#!/bin/bash

# Serviço utilizado
    # Amazon DynamoDB
    # Amazon CLI para execução em linha de comando

# Comandos para execução do experimento:


# Criar uma tabela


aws dynamodb create-table \
    --table-name Music \
    --attribute-definitions \
        AttributeName=Artist,AttributeType=S \
        AttributeName=SongTitle,AttributeType=S \
        AttributeName=AlbumTitle,AttributeType=S \
        AttributeName=SongYear,AttributeType=S \
    --key-schema \
        AttributeName=Artist,KeyType=HASH \
        AttributeName=SongTitle,KeyType=RANGE \
    --provisioned-throughput \
        ReadCapacityUnits=10,WriteCapacityUnits=5 \
    --global-secondary-indexes \
        "[
            {
                \"IndexName\":\"AlbumTitle-index\",
                \"KeySchema\":[
                    {
                        \"AttributeName\":\"AlbumTitle\",
                        \"KeyType\":\"HASH\"
                    }
                ],
                \"ProvisionedThroughput\":{
                    \"ReadCapacityUnits\":10,
                    \"WriteCapacityUnits\":5
                },
                \"Projection\":{
                    \"ProjectionType\":\"ALL\"
                }
            },
            {
                \"IndexName\":\"ArtistAlbumTitle-index\",
                \"KeySchema\":[
                    {
                        \"AttributeName\":\"Artist\",
                        \"KeyType\":\"HASH\"
                    },
                    {
                        \"AttributeName\":\"AlbumTitle\",
                        \"KeyType\":\"RANGE\"
                    }
                ],
                \"ProvisionedThroughput\":{
                    \"ReadCapacityUnits\":10,
                    \"WriteCapacityUnits\":5
                },
                \"Projection\":{
                    \"ProjectionType\":\"ALL\"
                }
            },
            {
                \"IndexName\":\"SongTitleYear-index\",
                \"KeySchema\":[
                    {
                        \"AttributeName\":\"SongTitle\",
                        \"KeyType\":\"HASH\"
                    },
                    {
                        \"AttributeName\":\"SongYear\",
                        \"KeyType\":\"RANGE\"
                    }
                ],
                \"ProvisionedThroughput\":{
                    \"ReadCapacityUnits\":10,
                    \"WriteCapacityUnits\":5
                },
                \"Projection\":{
                    \"ProjectionType\":\"ALL\"
                }
            }
        ]"