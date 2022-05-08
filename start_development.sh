#iniciando banco de dados
sudo docker-compose up -d postgres

#iniciando app em modo de debug
sudo docker-compose run --service-ports api
