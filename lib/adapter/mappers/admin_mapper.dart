import 'package:finance_control/data/models/admin.dart';

class AdminMapper {
  const AdminMapper();

  Map<String, dynamic> toMap(Admin admin) => admin.toMap();

  Admin fromMap(Map<String, dynamic> map) => Admin.fromMap(map);
}