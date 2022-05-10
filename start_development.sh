#iniciando banco de dados
sudo docker-compose up -d postgres

#inicia api para mostrando os logs no terminal
sudo docker-compose run --service-ports api

#criando o banco de dados
docker-compose run api rails db:create
docker-compose run api rails db:migrate
docker-compose run api rails db:seed