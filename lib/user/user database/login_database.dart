import 'package:hive/hive.dart';

part 'login_database.g.dart';

@HiveType(typeId: 1)
class User extends HiveObject {
  @HiveField(0)
  final String email;

  @HiveField(1)
  final String password;
  @HiveField(3)
  final String? name;
  @HiveField(4)
  final String? number;

  User({required this.email, required this.password, this.name, this.number});
}
