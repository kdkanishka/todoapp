import 'package:json_annotation/json_annotation.dart';

part 'todoentry.g.dart';

@JsonSerializable()
class ToDoEntry {
  int id;
  String text;
  bool done;

  ToDoEntry(this.id, this.text, this.done);

  factory ToDoEntry.fromJson(Map<String,dynamic> json)=> _$ToDoEntryFromJson(json);

  Map<String,dynamic> toJson() => _$ToDoEntryToJson(this);
}