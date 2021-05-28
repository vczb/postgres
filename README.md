# Criando um container do docker com o postgres


Durante a inicialização roda script sh para criar database e usuário
  
Informações setadas no environment do Dockerfile

environment:
  - "DB_USER=my_user"
  - "DB_PASSWORD=my_password"
  - "DB_DATABASE=my_database"
  - "POSTGRES_PASSWORD=password"
