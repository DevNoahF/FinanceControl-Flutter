import 'package:flutter_test/flutter_test.dart';
import 'package:finance_control/models/admin.dart';

void main() {

  test('fromJson cria Admin corretamente', () {
    final json = {
      "id": 1,
      "email": "admin@email.com",
      "senha": "123"
    };

    final admin = Admin.fromJson(json);
    expect(admin.email, "admin@email.com");
    expect(admin.senha, "123");
  });

  test('toJson retorna JSON correto', () {
    const admin = Admin(
      email: "admin@email.com",
      senha: "123",
    );

    final json = admin.toJson();

    expect(json["id"], 1);
    expect(json["email"], "admin@email.com");
    expect(json["senha"], "123");
  });

  test('copyWith altera apenas campos informados', () {
    const admin = Admin(
      email: "admin@email.com",
      senha: "123",
    );

    final novoAdmin = admin.copyWith(email: "novo@email.com");

    expect(novoAdmin.email, "novo@email.com");
    expect(novoAdmin.senha, "123");
  });
}