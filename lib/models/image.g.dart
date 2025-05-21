// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ImageMappingAdapter extends TypeAdapter<ImageMapping> {
  @override
  final int typeId = 3;

  @override
  ImageMapping read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ImageMapping(
      id: fields[0] as int,
      imageFile: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ImageMapping obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.imageFile);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ImageMappingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
