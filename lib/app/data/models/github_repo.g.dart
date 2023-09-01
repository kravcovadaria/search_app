// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'github_repo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GithubRepoAdapter extends TypeAdapter<GithubRepo> {
  @override
  final int typeId = 0;

  @override
  GithubRepo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GithubRepo(
      url: fields[0] as String,
      name: fields[1] as String,
      favourite: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, GithubRepo obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.url)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.favourite);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GithubRepoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
