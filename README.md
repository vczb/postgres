# Criando um container do docker com o postgres


Durante a inicialização roda script sh para criar database e tabela inicial
  
Informações setadas no environment do Dockerfile

environment:
  - "DB_USER=vini"
  - "DB_PASSWORD=vini"
  - "DB_DATABASE=vinidb"
  - "POSTGRES_PASSWORD=password"
