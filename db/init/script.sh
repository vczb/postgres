#!/bin/bash

# Sai imediatamente se ocorrer algum erro durante o script
# execução. Se não definido, pode ocorrer um erro e o
# script continuaria sua execução.
set -o errexit


# Criando uma matriz que define as variáveis de ambiente
# que deve ser definido. Isso pode ser consumido mais tarde via arrray
# expansão variável $ {REQUIRED_ENV_VARS [@]}.
readonly REQUIRED_ENV_VARS=(
  "DB_USER"
  "DB_PASSWORD"
  "DB_DATABASE"
  "POSTGRES_USER")


# Execução principal:
# - verifica se todas as variáveis de ambiente estão definidas
# - executa o código SQL para criar usuário e banco de dados
main() {
  check_env_vars_set
  init_user_and_db
}


# Verifica se todo o ambiente necessário
# variáveis estão definidas. Se um deles não é,
# reproduz um texto explicando qual não é
# e o nome dos que precisam ser
check_env_vars_set() {
  for required_env_var in ${REQUIRED_ENV_VARS[@]}; do
    if [[ -z "${!required_env_var}" ]]; then
      echo "Error:
    Environment variable '$required_env_var' not set.
    Make sure you have the following environment variables set:
      ${REQUIRED_ENV_VARS[@]}
Aborting."
      exit 1
    fi
  done
}

# Executa a inicialização no PostgreSQL já iniciado
# usando o usuário POSTGRE_USER pré-configurado.
init_user_and_db() {
  psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
     CREATE USER $DB_USER WITH PASSWORD '$DB_PASSWORD';
     CREATE DATABASE $DB_DATABASE;
     GRANT ALL PRIVILEGES ON DATABASE $DB_DATABASE TO $DB_USER;

     \c $DB_DATABASE $DB_USER

     CREATE TABLE IF NOT EXISTS cliente (nome TEXT);

EOSQL
}

# Executa a rotina principal com variáveis de ambiente
main "$@"
