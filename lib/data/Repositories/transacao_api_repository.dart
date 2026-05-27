import 'package:finance_control/data/cache/cache_service.dart';
import 'package:finance_control/data/services/transacao_service.dart';
import 'package:finance_control/models/transacao.dart';

class TransacaoApiRepository {
  final TransacaoService _service;
  final CacheService _cache;
  final Duration _cacheTtl;

  TransacaoApiRepository({
    required TransacaoService service,
    required CacheService cache,
    Duration cacheTtl = const Duration(minutes: 10),
  })  : _service = service,
        _cache = cache,
        _cacheTtl = cacheTtl;

  Future<List<Transacao>> getTransacoes({bool forceRefresh = false}) async {
    if (!forceRefresh) {
      final cached = await _cache.getJson(_transacoesKey, _cacheTtl);
      if (cached is List) {
        try {
          return cached
              .map((item) => Transacao.fromJson(item as Map<String, dynamic>))
              .toList();
        } catch (_) {
          // se der erro no cache, busca na API
        }
      }
    }

    final transacoes = await _service.getTransacoes();
    await _cache.setJson(
      _transacoesKey,
      transacoes.map((t) => t.toJson()).toList(),
    );
    return transacoes;
  }

  Future<Transacao> getTransacaoById(int id, {bool forceRefresh = false}) async {
    final key = _transacaoKey(id);
    if (!forceRefresh) {
      final cached = await _cache.getJson(key, _cacheTtl);
      if (cached is Map<String, dynamic>) {
        try {
          return Transacao.fromJson(cached);
        } catch (_) {
          // se der erro no cache, busca na API
        }
      }
    }

    final transacao = await _service.getTransacaoById(id);
    await _cache.setJson(key, transacao.toJson());
    return transacao;
  }

  static String _transacaoKey(int id) => 'cache_transacao_$id';
  static const String _transacoesKey = 'cache_transacoes';
}
