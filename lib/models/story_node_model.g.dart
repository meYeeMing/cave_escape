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
      isVictory: fields[4] as bool,
      isGameOver: fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, StoryNodeModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.text)
      ..writeByte(2)
      ..write(obj.imageId)
      ..writeByte(3)
      ..write(obj.choices)
      ..writeByte(4)
      ..write(obj.isVictory)
      ..writeByte(5)
      ..write(obj.isGameOver);
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
