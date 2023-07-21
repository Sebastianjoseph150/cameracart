import 'package:hive/hive.dart';

part 'Address_db.g.dart';

@HiveType(typeId: 2)
class Address {
  @HiveField(0)
  String name;

  @HiveField(1)
  String Addressline1;

  @HiveField(2)
  String Addressline2;

  @HiveField(3)
  String pin;

  @HiveField(4)
  String state;

  Address({
    required this.name,
    required this.Addressline1,
    required this.Addressline2,
    required this.pin,
    required this.state,
  });
}
