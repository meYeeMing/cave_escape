// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_state_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GameStateModelAdapter extends TypeAdapter<GameStateModel> {
  @override
  final int typeId = 2;

  @override
  GameStateModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GameStateModel(
      id: fields[0] as int,
      winLoss: fields[1] as bool,
      completionTimeInSeconds: fields[2] as int,
      movesTaken: fields[3] as int,
      playedAt: fields[4] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, GameStateModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.winLoss)
      ..writeByte(2)
      ..write(obj.completionTimeInSeconds)
      ..writeByte(3)
      ..write(obj.movesTaken)
      ..writeByte(4)
      ..write(obj.playedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GameStateModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
