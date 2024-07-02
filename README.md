# Sistema de Mensagem App

Sistema de Mensagem App é uma aplicação Rails para gerenciar usuários com funcionalidades de autenticação, suspensão e envio de emails de boas-vindas.

## Sumário

- [Pré-requisitos](#pré-requisitos)
- [Instalação](#instalação)
- [Execução](#instalação)
- [Testes](#testes)
- [API Endpoints](#testes)
- [Cache](#cache)
- [Contribuição](#contribuição)
- [Licença](#licença)

## Pré-requisitos

- Ruby 3.2.0
- Rails 7.0.8.4
- PostgreSQL
- Redis

## Instalação

1. Clone o repositório:

   ```sh
   git clone https://github.com/usuario/sistema-mensagem-app.git
   cd sistema-mensagem-app

## Setup
```bash
# Instalar gems
$ bundle install

# Cria o banco de dados
$ rails db:create

# Rodar as migrações no banco de dados
$ rails db:migrate

# Subir o servidor local em localhost:3000
$ rails s
```
## Testes
Para executar todos os casos de teste, utilize o seguinte comando
```bash
$ bundle exec rspec

```
## API Documentation
```bash
## Autenticação

### Login
**Endpoint:** `POST /auth/sign_in`

**Request Body:**
```json
{
  "email": "admin1@example.com",
  "password": "123456"
}

Listar Usuários
Endpoint: GET /api/v1/users

Atualizar Usuário
Endpoint: PUT /api/v1/users/:id

Request Body:
{
  "user": {
    "name": "Novo Nome"
  }
}

Suspender Usuário
Endpoint: GET /api/v1/admin/users/:id/suspend

Deletar Usuário
Endpoint: DELETE /api/v1/admin/users/:id

Body (raw, JSON):
{
  "email": "admin1@example.com",
  "password": "123456"
}

Cache
O sistema utiliza Redis para cache. Configuração básica pode ser encontrada no arquivo de configuração do ambiente (config/environments/development.rb).

