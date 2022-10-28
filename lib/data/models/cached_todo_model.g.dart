// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cached_todo_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CachedTodoModelAdapter extends TypeAdapter<CachedTodoModel> {
  @override
  final int typeId = 0;

  @override
  CachedTodoModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CachedTodoModel()
      ..title = fields[1] as String
      ..desc = fields[2] as String
      ..todoType = fields[3] as String
      ..createdAt = fields[4] as String;
  }

  @override
  void write(BinaryWriter writer, CachedTodoModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.desc)
      ..writeByte(3)
      ..write(obj.todoType)
      ..writeByte(4)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CachedTodoModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
