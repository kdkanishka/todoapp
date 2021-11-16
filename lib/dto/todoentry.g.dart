// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todoentry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ToDoEntry _$ToDoEntryFromJson(Map<String, dynamic> json) {
  return ToDoEntry(
    json['id'] as int,
    json['text'] as String,
    json['done'] as bool,
  );
}

Map<String, dynamic> _$ToDoEntryToJson(ToDoEntry instance) => <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'done': instance.done,
    };
