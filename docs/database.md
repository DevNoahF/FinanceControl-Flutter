# Banco de Dados Atual

Este arquivo descreve como a persistencia do projeto esta funcionando hoje.

## Visao Geral

No estado atual existem duas camadas de persistencia preparadas no projeto:

1. SQLite local, criado em `lib/data/database/app_database.dart`.
2. MySQL via Docker, criado por `docker-compose.yaml` e inicializado com `docker/mysql/init.sql`.

A app Flutter nao grava direto no MySQL do Docker. O banco que o app usa na pratica é o SQLite local.

No navegador, esse SQLite usa suporte web do `sqflite`. Para funcionar bem, ele precisa dos binarios auxiliares do worker. Quando isso nao esta configurado, o app pode abrir a pagina e mostrar so a barra superior, ou ficar em branco, porque a inicializacao do banco falha antes do restante da tela montar.

## O Que Ja Esta Pronto

- Os modelos `Usuario`, `Admin` e `Transacao` possuem `toMap()` e `fromMap()`.
- A senha usa hash simples com SHA-256 no fluxo de autenticacao.
- O SQLite local ja tem helper com `openDatabase()`, `PRAGMA foreign_keys = ON`, tabelas e indices.
- O Docker sobe MySQL 8 e cria automaticamente as tabelas base do schema.
- Existe separacao entre dominio e infraestrutura com interfaces em `lib/domain/repositories` e implementacoes em `lib/data/repositories`.
- Os repositórios em memoria que eu tinha criado foram apenas um atalho temporario para testar o navegador e explicar o problema; eles foram removidos para manter o codigo limpo.

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
- O banco do Docker nao recebe os dados da interface automaticamente.
- Nao existe sincronizacao entre SQLite local e MySQL.
- No web, a persistencia depende dos binarios do `sqflite`; sem eles o app pode nao desenhar a tela inteira.

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

Se voce inserir dados pela interface hoje, eles vao para o SQLite local da app.
O Docker esta servindo como base de schema e inspecao agora.
Se o navegador abrir branco ou mostrar so a faixa superior, isso normalmente quer dizer que o SQLite web nao inicializou direito.
O jeito mais seguro de demonstrar o app, neste estado, é usar desktop ou ajustar o suporte web do `sqflite`.