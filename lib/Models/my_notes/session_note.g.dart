// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_note.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SessionNoteAdapter extends TypeAdapter<SessionNote> {
  @override
  final int typeId = 1;

  @override
  SessionNote read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SessionNote(
      trainingId: fields[0] as int,
      sessionId: fields[1] as int,
      noteText: fields[2] as String,
      createdAt: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, SessionNote obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.trainingId)
      ..writeByte(1)
      ..write(obj.sessionId)
      ..writeByte(2)
      ..write(obj.noteText)
      ..writeByte(3)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SessionNoteAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
