import 'package:finance_control/models/transacao.dart';

class TransacaoMapper {
  const TransacaoMapper();

  Map<String, dynamic> toMap(Transacao transacao) => transacao.toMap();

  Transacao fromMap(Map<String, dynamic> map) => Transacao.fromMap(map);
}