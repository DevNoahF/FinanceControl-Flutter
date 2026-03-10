import 'package:flutter_test/flutter_test.dart';
import 'package:finance_control/models/category.dart';
import 'package:finance_control/models/enums.dart';

void main() {
  test('fromJson cria a categoria corretamente', () {
    final json = {
      'id': 'cat1',
      'nome': 'Comida',
      'tipo': 'food',
      'descricao': 'Gastos com alimentação',
    };

    final categoria = Category.fromJson(json);

    expect(categoria.id, 'cat1');
    expect(categoria.nome, 'Comida');
    expect(categoria.tipo, CategoryType.food);
    expect(categoria.descricao, 'Gastos com alimentação');
  });

  test('toJson gera o mapa corretamente', () {
    const categoria = Category(
      id: 'cat1',
      nome: 'Comida',
      tipo: CategoryType.food,
      descricao: 'Gastos com alimentação',
    );

    final json = categoria.toJson();

    expect(json['id'], 'cat1');
    expect(json['nome'], 'Comida');
    expect(json['tipo'], 'food');
    expect(json['descricao'], 'Gastos com alimentação');
  });

  test('copyWith altera apenas os campos informados', () {
    const categoria = Category(
      id: 'cat1',
      nome: 'Comida',
      tipo: CategoryType.food,
      descricao: 'Gastos com alimentação',
    );

    final novaCategoria = categoria.copyWith(nome: 'Alimentação');

    expect(novaCategoria.id, 'cat1');
    expect(novaCategoria.nome, 'Alimentação');
    expect(novaCategoria.tipo, CategoryType.food);
    expect(novaCategoria.descricao, 'Gastos com alimentação');
  });
}