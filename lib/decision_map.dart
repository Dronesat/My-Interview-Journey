import 'package:hive/hive.dart';
part 'decision_map.g.dart';

@HiveType(typeId: 0)
class DecisionMap{

  @HiveField(0)
  late int nodeID;

  @HiveField(1)
  late int yesID;

  @HiveField(2)
  late int noID;

  @HiveField(3)
  late String description;

  @HiveField(4)
  late String question;

  DecisionMap(this.nodeID, this.yesID, this.noID, this.description, this.question);

}