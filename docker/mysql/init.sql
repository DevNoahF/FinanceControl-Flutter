CREATE DATABASE IF NOT EXISTS finance_control;
USE finance_control;

CREATE TABLE IF NOT EXISTS usuarios (
  id INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(120) NOT NULL,
  sobrenome VARCHAR(120) NOT NULL,
  email VARCHAR(180) NOT NULL,
  senha_hash VARCHAR(255) NOT NULL,
  profissao VARCHAR(120) NOT NULL DEFAULT '',
  idade INT NOT NULL,
  role VARCHAR(30) NOT NULL DEFAULT 'user',
  created_at DATETIME NOT NULL,
  updated_at DATETIME NULL,
  sincronizado TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (id),
  UNIQUE KEY uq_usuarios_email (email),
  KEY idx_usuarios_role (role)
);

CREATE TABLE IF NOT EXISTS admin (
  id INT NOT NULL AUTO_INCREMENT,
  email VARCHAR(180) NOT NULL,
  senha_hash VARCHAR(255) NOT NULL,
  role VARCHAR(30) NOT NULL DEFAULT 'adm',
  sincronizado TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (id),
  UNIQUE KEY uq_admin_email (email)
);

CREATE TABLE IF NOT EXISTS transacoes (
  id INT NOT NULL AUTO_INCREMENT,
  user_id INT NOT NULL,
  titulo VARCHAR(180) NOT NULL,
  descricao TEXT NOT NULL,
  data DATETIME NOT NULL,
  tipo VARCHAR(30) NOT NULL,
  valor DECIMAL(12,2) NOT NULL,
  sincronizado TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (id),
  KEY idx_transacoes_user_id (user_id),
  KEY idx_transacoes_tipo (tipo),
  KEY idx_transacoes_data (data),
  CONSTRAINT fk_transacoes_usuario
    FOREIGN KEY (user_id) REFERENCES usuarios(id)
    ON DELETE CASCADE
);