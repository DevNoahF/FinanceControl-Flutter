# API Contract


Este contrato reflete os models atuais: Admin, Usuario, Transacao.

## Auth

### POST /auth/login
Autentica admin ou usuario.

Headers:
- Content-Type: application/json

Body:
```json
{
  "email": "admin@exemplo.com",
  "senha": "123456"
}
```

Response 200:
```json
{
  "token": "jwt.access.token",
  "admin": {
    "email": "admin@exemplo.com",
    "senha": "123456"
  }
}
```

## Usuarios

### GET /usuarios
Lista usuarios.

Response 200:
```json
[
  {
    "id": 1,
    "nome": "Joao",
    "sobrenome": "Silva",
    "email": "joao@exemplo.com",
    "senha": "123456",
    "idade": 20,
    "created_at": "2026-05-27T12:00:00Z",
    "updated_at": null
  }
]
```

### POST /usuarios
Cria usuario.

Headers:
- Content-Type: application/json

Body:
```json
{
  "nome": "Joao",
  "sobrenome": "Silva",
  "email": "joao@exemplo.com",
  "senha": "123456",
  "idade": 20,
}
```

Response 201:
```json
{
  "id": 1,
  "nome": "Joao",
  "sobrenome": "Silva",
  "email": "joao@exemplo.com",
  "senha": "123456",
  "idade": 20,
  "created_at": "2026-05-27T12:00:00Z",
  "updated_at": null
}
```


### GET /usuarios/{id}
Retorna usuario por id.

Response 200:
```json
{
  "id": 1,
  "nome": "Joao",
  "sobrenome": "Silva",
  "email": "joao@exemplo.com",
  "senha": "123456",
  "idade": 20,
  "created_at": "2026-05-27T12:00:00Z",
  "updated_at": null
}
```


## Transacoes

### GET /transacoes
Lista transacoes.

Response 200:
```json
[
  {
    "id":1,
    "user_id":"1",
    "titulo": "Salario",
    "descricao": "Pagamento mensal",
    "valor": 3500.0,
    "isEntrada": true
  },
  {
    "id":2,
    "user_id":1,
    "titulo": "Mercado",
    "descricao": "Compras da semana",
    "valor": 120.5,
    "isEntrada": false
  }
]
```


### POST /transacoes
Cria transacao.

Headers:
- Content-Type: application/json

Body:
```json
{
  "titulo": "Mercado",
  "descricao": "Compras da semana",
  "valor": 120.5,
  "isEntrada": false
}
```

Response 201:
```json
{
  "id":1,
  "user_id":1,
  "titulo": "Mercado",
  "descricao": "Compras da semana",
  "valor": 120.5,
  "isEntrada": false
}
```