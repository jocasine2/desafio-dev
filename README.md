# README
docker-compose run --service-ports api

# Atualize o banco de dados
docker-compose run api rails db:create
docker-compose run api rails db:migrate
docker-compose run api rails db:seed