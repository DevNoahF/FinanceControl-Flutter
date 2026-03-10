import 'package:flutter_test/flutter_test.dart';
import 'package:finance_control/models/Usuario.dart';

void main() {
    final data = DateTime.now();
  test('fromJson cria usuario corretamente', () {
    final json = {
      "id": 1,
      "nome": "Ana",
      "sobrenome": "Silva",
      "email": "ana@email.com",
      "senha": "123",
      "profissao": "Dev",
      "idade": 25,
      "created_at": data.toString(),
    };

    final usuario = Usuario.fromJson(json);

    expect(usuario.nome, "Ana");
    expect(usuario.idade, 25);
    print("Dados após criar usuário");
    print(usuario.toJson());
  });
  

  test('toJson gera json correto', () {
    final usuario = Usuario(
      id: 1,
      nome: "Ana",
      sobrenome: "Silva",
      email: "ana@email.com",
      senha: "123",
      profissao: "Dev",
      idade: 25,
      created_at: data,
    );

    final json = usuario.toJson();

    expect(json["nome"], "Ana");
    expect(json["idade"], 25);
    print("Dados após gerar json correto");
      print(usuario.toJson());
  });

  test('copyWith altera apenas campos enviados', () {
    final usuario = Usuario(
      id: 1,
      nome: "Ana",
      sobrenome: "Silva",
      email: "a@email.com",
      senha: "12345",
      profissao: "Advogada",
      idade: 25,
      created_at: DateTime.now(),
      updated_at: DateTime.now(),
    );

    final novo = usuario.copyWith(nome: "Maria");

    expect(novo.nome, "Maria");
    expect(novo.email, usuario.email);

    print("Dados após mudanças nos campos");
    print(novo.toJson());

  });
  
}