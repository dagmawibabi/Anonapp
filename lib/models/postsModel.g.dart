// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'postsModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PostsModelAdapter extends TypeAdapter<PostsModel> {
  @override
  final int typeId = 0;

  @override
  PostsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PostsModel()
      ..username = fields[0] as String
      ..datetime = fields[1] as int
      ..content = fields[2] as String;
  }

  @override
  void write(BinaryWriter writer, PostsModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.username)
      ..writeByte(1)
      ..write(obj.datetime)
      ..writeByte(2)
      ..write(obj.content);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PostsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
