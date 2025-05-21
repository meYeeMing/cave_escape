// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_node_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StoryNodeModelAdapter extends TypeAdapter<StoryNodeModel> {
  @override
  final int typeId = 0;

  @override
  StoryNodeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StoryNodeModel(
      id: fields[0] as int,
      text: fields[1] as String,
      imageId: fields[2] as int,
      choices: (fields[3] as List).cast<StoryChoiceModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, StoryNodeModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.text)
      ..writeByte(2)
      ..write(obj.imageId)
      ..writeByte(3)
      ..write(obj.choices);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StoryNodeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
