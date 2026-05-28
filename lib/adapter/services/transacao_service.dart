import 'package:finance_control/data/services/api_client.dart';
import 'package:finance_control/models/transacao.dart';

class TransacaoService {
  final ApiClient _client;

  const TransacaoService(this._client);

  Future<List<Transacao>> getTransacoes() async {
    final data = await _client.get('/transacoes');
    if (data is! List) {
      throw const FormatException('Invalid transacoes response format');
    }
    return data
        .map((item) => Transacao.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<Transacao> getTransacaoById(int id) async {
    final data = await _client.get('/transacoes/$id');
    if (data is! Map<String, dynamic>) {
      throw const FormatException('Invalid transacao response format');
    }
    return Transacao.fromJson(data);
  }

  Future<Transacao> createTransacao(Transacao transacao) async {
    final data = await _client.post('/transacoes', transacao.toJson());
    if (data is! Map<String, dynamic>) {
      throw const FormatException('Invalid transacao response format');
    }
    return Transacao.fromJson(data);
  }
}
