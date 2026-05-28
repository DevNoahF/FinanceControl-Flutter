import 'package:finance_control/domain/repositories/transacao_repository.dart';
import 'package:finance_control/models/transacao.dart';

class MemoryTransacaoRepository implements ITransacaoRepository {
  final List<Transacao> _transacoes = [];

  int get _nextId {
    if (_transacoes.isEmpty) return 1;
    return _transacoes.map((t) => t.id).reduce((a, b) => a > b ? a : b) + 1;
  }

  @override
  Future<int> insert(Transacao transacao) async {
    final nextId = transacao.id == 0 ? _nextId : transacao.id;
    _transacoes.add(transacao.copyWith(id: nextId));
    return nextId;
  }

  @override
  Future<List<Transacao>> getAll() async => List.unmodifiable(_transacoes);

  @override
  Future<List<Transacao>> getByUserId(int userId) async {
    return _transacoes.where((transacao) => transacao.userId == userId).toList();
  }

  @override
  Future<Transacao?> getById(int id) async {
    try {
      return _transacoes.firstWhere((transacao) => transacao.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<int> update(Transacao transacao) async {
    final index = _transacoes.indexWhere((item) => item.id == transacao.id);
    if (index == -1) return 0;
    _transacoes[index] = transacao;
    return 1;
  }

  @override
  Future<int> delete(int id) async {
    final before = _transacoes.length;
    _transacoes.removeWhere((transacao) => transacao.id == id);
    return before - _transacoes.length;
  }
}