import 'package:finance_control/data/models/Usuario.dart';

class UsuarioMapper {
  const UsuarioMapper();

  Map<String, dynamic> toMap(Usuario usuario) => usuario.toMap();

  Usuario fromMap(Map<String, dynamic> map) => Usuario.fromMap(map);
}