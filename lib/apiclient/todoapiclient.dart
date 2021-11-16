import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:todoapp/dto/todoentry.dart';

part 'todoapiclient.g.dart';

@RestApi(baseUrl: "http://localhost:8080/")
abstract class ToDoApiClient {
  factory ToDoApiClient(Dio dio, {String baseUrl}) = _ToDoApiClient;

  @GET("/todo")
  Future<List<ToDoEntry>> getAll();

  @POST("/todo")
  Future<ToDoEntry> create(@Body() ToDoEntry toDoEntry);

  @PUT("/todo")
  Future<ToDoEntry> update(@Body() ToDoEntry toDoEntry);

  @DELETE("/todo/{id}")
  Future delete(@Path("id") int id);

}