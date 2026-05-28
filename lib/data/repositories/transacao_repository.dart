import 'package:finance_control/data/models/transacao.dart';

abstract interface class ITransacaoRepository {
	Future<int> insert(Transacao transacao);
	Future<List<Transacao>> getAll();
	Future<List<Transacao>> getByUserId(int userId);
	Future<Transacao?> getById(int id);
	Future<int> update(Transacao transacao);
	Future<int> delete(int id);
}