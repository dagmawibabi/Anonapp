import 'package:hive/hive.dart';

part 'postsModel.g.dart';

@HiveType(typeId: 0)
class PostsModel extends HiveObject {
  @HiveField(0)
  late String username;

  @HiveField(1)
  late int datetime;
}
