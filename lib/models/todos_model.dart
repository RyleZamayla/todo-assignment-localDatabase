class  Todo {
  int id;
  String titleTodos, descTodos;

  Todo({required this.descTodos, required this.titleTodos, required this.id});

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(id: json['id'] as int, titleTodos: json['titleTodos'] as String, descTodos: json['descTodos'] as String);
  }
}