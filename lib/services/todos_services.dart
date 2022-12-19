import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:todo_assignment2/models/todos_model_lApi.dart';

class Services {
  static const root = 'http://localhost/todo-assignment-localDatabase/todo_actions.php';
  static const createTableAction = 'CREATE_TABLE';
  static const getAllAction = 'GET_ALL';
  static const addTodoAction = 'ADD_TODO';
  static const updateTodoAction = 'UPDATE_TODO';
  static const deleteTodoId = 'DELETE_TODO';

  static Future<String> createTable() async{
    try{
      var map = <String, dynamic>{};
      map['action'] = createTableAction;
      final response = await http.post(Uri.parse(root), body: map);
      print("Create table response: ${response.body}");
      if(200 == response.statusCode){
        return response.body;
      }
      else{
        return "error executing 'try createTable' method...";
      }
    }catch(e){
      return "error executing 'createTable' method...";
    }
  }

  static Future<List<Todo>> getTodo() async{
    try{
      var map = <String, dynamic>{};
      map['action'] = getAllAction;
      final response = await http.post(Uri.parse(root), body: map);
      print("Create table response: ${response.body}");
      if(200 == response.statusCode){
        List<Todo> list = parseResponse(response.body);
        return list;
      }
      else{
        return <Todo>[];
      }
    }
    catch (e){
      return <Todo>[];
    }
  }

  static List<Todo> parseResponse(String responseBody){
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Todo>((json)=> Todo.fromJson(json)).toList();
  }

  static Future<String> addTodo(String titleTodos, String descTodos) async{
    try{
      var map = <String, dynamic>{};
      map['action'] = addTodoAction;
      final response = await http.post(Uri.parse(root), body: map);
      print("Create table response: ${response.body}");
      if(200 == response.statusCode){
        return response.body;
      }
      else{
        return "error executing 'try addTodo' method...";
      }
    }
    catch (e){
      return "error executing 'addTodo' method...";
    }
  }

  static Future<String> updateTodo(
      int todoId, String titleTodos, String descTodos
      ) async {
    try{
      var map = <String, dynamic>{};
      map['action'] = updateTodoAction;
      map['todoId'] = todoId;
      map['titleTodos'] = titleTodos;
      map['descTodos'] = descTodos;
      final response = await http.post(Uri.parse(root), body: map);
      print("Update todo response: ${response.body}");
      if(200 == response.statusCode){
        return response.body;
      }
      else{
        return "error executing 'try updateTodo' method...";
      }
    }
    catch(e){
      return "error executing 'updateTodo' method...";
    }
  }

  static Future<String> deleteTodo(int todoId) async {
    try{
      var map = <String, dynamic>{};
      map['action'] = deleteTodoId;
      map['todoId'] = todoId;
      final response = await http.post(Uri.parse(root), body: map);
      print("Delete todo response: ${response.body}");
      if(200 == response.statusCode){
        return response.body;
      }
      else{
        return "error executing 'try updateTodo' method...";
      }
    }
    catch(e){
      return "error executing 'updateTodo' method...";
    }
  }


}

