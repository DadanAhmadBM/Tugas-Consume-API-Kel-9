import 'dart:convert';
import 'dart:io';

import '../models/todo.dart';
import '../services/todo_services.dart';

class TodoController {
  Future<List<Todo>> fetchTodos() async {
    return await TodoServices().fetch().then((res) {
      if (res.statusCode == HttpStatus.ok) {
        var jsonData = jsonDecode(res.body);
        return List.generate(
          jsonData.length,
          (index) => Todo.fromMap(
            jsonData[index],
          ),
        );
      } else {
        throw Exception();
      }
    });
  }
}
