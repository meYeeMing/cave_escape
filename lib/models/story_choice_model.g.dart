// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_choice_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StoryChoiceModelAdapter extends TypeAdapter<StoryChoiceModel> {
  @override
  final int typeId = 1;

  @override
  StoryChoiceModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StoryChoiceModel(
      text: fields[0] as String,
      nextNodeId: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, StoryChoiceModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.text)
      ..writeByte(1)
      ..write(obj.nextNodeId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StoryChoiceModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
