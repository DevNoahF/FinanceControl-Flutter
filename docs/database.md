# Banco de Dados Atual

Este arquivo descreve como a persistencia do projeto esta funcionando hoje.

## Visao Geral

No estado atual existem duas camadas de persistencia preparadas no projeto:

1. SQLite local, criado em `lib/data/database/app_database.dart`.
2. MySQL via Docker, criado por `docker-compose.yaml` e inicializado com `docker/mysql/init.sql`.

A app Flutter ainda nao esta ligada ao MySQL do Docker para gravar dados em tempo real. O codigo de tela e os notifiers continuam usando a logica atual em memoria, enquanto a infraestrutura de banco foi deixada pronta para evolucao.

## O Que Ja Esta Pronto

- Os modelos `Usuario`, `Admin` e `Transacao` possuem `toMap()` e `fromMap()`.
- A senha usa hash simples com SHA-256 no fluxo de autenticacao.
- O SQLite local ja tem helper com `openDatabase()`, `PRAGMA foreign_keys = ON`, tabelas e indices.
- O Docker sobe MySQL 8 e cria automaticamente as tabelas base do schema.
- Existe separacao inicial entre dominio e infraestrutura com interfaces em `lib/domain/repositories` e implementacoes em `lib/data/repositories`.

## Estrutura Do MySQL No Docker

O arquivo `docker/mysql/init.sql` cria estas tabelas:

- `usuarios`
- `admin`
- `transacoes`

Relacionamento principal:

- `transacoes.user_id` referencia `usuarios.id` com `ON DELETE CASCADE`.

Indices principais:

- `usuarios.email`
- `usuarios.role`
- `admin.email`
- `transacoes.user_id`
- `transacoes.tipo`
- `transacoes.data`

## O Que Ainda Nao Esta Integrado

- A app nao usa o MySQL do Docker como banco de execucao.
- O `main.dart` ainda nao chama o `configureDependencies()` do GetIt.
- Os repositrios SQLite existem, mas ainda nao tem CRUD implementado.
- Nao existe sincronizacao entre SQLite local e MySQL.

## Como Ver O Banco Docker

Subir o container:

```bash
docker compose up -d
```

Ver as tabelas:

```bash
docker exec financeControl_mysql mysql -ufinance_user -proot finance_control -e "SHOW TABLES;"
```

Ver indices da tabela de transacoes:

```bash
docker exec financeControl_mysql mysql -ufinance_user -proot finance_control -e "SHOW INDEX FROM transacoes;"
```

## Credenciais Padrao

- Host: `127.0.0.1`
- Porta: `3306`
- Banco: `finance_control`
- Usuario: `finance_user`
- Senha: `root`

## Resumo Pratico

Se voce inserir dados pela interface hoje, eles ainda nao vao para o MySQL do Docker.
O Docker esta servindo como base de schema e inspecao agora.
O proximo passo, quando voce quiser, e ligar os providers ao GetIt e trocar a persistencia da app para os repositrios reais.