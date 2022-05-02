import 'package:hive/hive.dart';

part 'item.g.dart';

@HiveType(typeId: 0)
class Item extends HiveObject {
  @HiveField(0)
  String category = "ICT";
  @HiveField(1)
  String name = " ";
  @HiveField(2)
  Map<String, double> details;
  Item(this.category, this.name, this.details);
}
