import 'package:flutter_test/flutter_test.dart';
import 'package:finance_control/models/transacao.dart';
import 'package:finance_control/models/enums.dart';

void main() {
  final mockJson = {
    'id': 1,
    'categoria_id': 10,
    'descricao': 'Almoço',
    'banco': 'inter',
    'data': '2023-10-27T10:00:00.000',
    'tipo': 'expense',
    'valor': 45.50
  };

  test('Deve criar objeto a partir do JSON (fromJson)', () {
    final transacao = Transacao.fromJson(mockJson);
    expect(transacao.id, 1);
    expect(transacao.banco, Banco.inter);
    expect(transacao.tipo, TransactionType.expense);
  });

  test('Deve converter objeto para JSON corretamente (toJson)', () {
    final transacao = Transacao(
      id: 1, categoriaId: 10, descricao: 'Almoço', 
      banco: Banco.inter, data: DateTime.parse('2023-10-27T10:00:00.000'), 
      tipo: TransactionType.expense, valor: 45.50
    );
    final json = transacao.toJson();
    expect(json['valor'], 45.50);
    expect(json['banco'], 'inter');
    expect(json['tipo'], 'expense');
  });

  test('Deve criar cópia com valor alterado (copyWith)', () {
    final transacao = Transacao.fromJson(mockJson);
    final novaTransacao = transacao.copyWith(valor: 100.0);
    expect(novaTransacao.valor, 100.0);
    expect(novaTransacao.id, transacao.id);
  });
}