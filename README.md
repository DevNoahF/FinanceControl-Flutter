# Finance Control

Aplicativo Flutter para controle financeiro.

Estado atual da persistência:
- a interface e os notifiers ainda operam em memória;
- a camada de SQLite local já existe em `lib/data/database` com schema e mappers preparados;
- o MySQL via Docker sobe com schema criado automaticamente, mas ainda nao recebe dados da app.

Para entender a estrutura de banco e o que esta ativo agora, leia [docs/database.md](docs/database.md).

## Pre-requisitos

Antes de rodar o projeto, instale:

- [Flutter](https://docs.flutter.dev/get-started/install)
- [Docker Desktop](https://www.docker.com/products/docker-desktop/)
- Git

Para conferir se o Flutter esta pronto:

```bash
flutter doctor
```

## Como rodar o projeto

Clone o repositorio e entre na pasta do projeto:

```bash
git clone <url-do-repositorio>
cd FinanceControl-Flutter
```

Instale as dependencias do Flutter:

```bash
flutter pub get
```

Crie seu arquivo de ambiente a partir do exemplo:

```bash
copy .env.example .env
```

No Linux ou macOS:

```bash
cp .env.example .env
```

Se quiser, altere os dados do banco no arquivo `.env`:

```env
MYSQL_CONTAINER_NAME=priorizze_mysql
MYSQL_VOLUME_NAME=priorizze_mysql_data
MYSQL_PORT=3306
MYSQL_DATABASE=finance_control
MYSQL_ROOT_PASSWORD=root
MYSQL_USER=finance_user
MYSQL_PASSWORD=finance_password
```

Suba o banco de dados:

```bash
docker compose up -d
```

Rode o aplicativo Flutter:

```bash
flutter run
```

## Dados do banco

Com a configuracao padrao do `.env.example`, o banco MySQL do Docker fica assim:

```text
Host: localhost
Porta: 3306
Banco: finance_control
Usuario: finance_user
Senha: finance_password
```

Se a porta `3306` ja estiver em uso na sua maquina, altere o `MYSQL_PORT` no `.env`, por exemplo:

```env
MYSQL_PORT=3307
```

Nesse caso, a conexao pelo seu computador deve usar a porta `3307`.

Observacao importante: esse banco do Docker esta preparado para schema e inspeção, mas a app Flutter ainda nao grava nele diretamente.

## Comandos uteis do Docker

Ver containers rodando:

```bash
docker ps
```

Parar o banco:

```bash
docker compose down
```

Ver logs do MySQL:

```bash
docker compose logs -f mysql
```

Entrar no MySQL pelo terminal:

```bash
docker compose exec mysql mysql -uroot -p
```

Quando pedir a senha, use o valor de `MYSQL_ROOT_PASSWORD` definido no seu `.env`.

## Observacao sobre mudancas no banco

O MySQL salva os dados no volume definido por `MYSQL_VOLUME_NAME`. Por isso, se voce subir o banco uma vez e depois mudar `MYSQL_DATABASE`, `MYSQL_ROOT_PASSWORD`, `MYSQL_USER` ou `MYSQL_PASSWORD`, o banco antigo pode continuar usando os dados anteriores.

Para apagar o volume e recriar o banco do zero:

```bash
docker compose down -v
docker compose up -d
```

Use esse comando somente se puder perder os dados locais do banco.

## Documentacao complementar

- [docs/database.md](docs/database.md) explica a arquitetura de persistencia atual, o schema e a diferenca entre SQLite local e MySQL no Docker.
