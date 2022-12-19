import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_assignment2/models/todos_model_LocalDB.dart';

class TodoCard extends StatefulWidget {

  final int id;
  final String title;
  final DateTime creationDate;
  late final bool isChecked;
  final Function insertFunction;
  final Function deleteFunction;
  // ignore: prefer_const_constructors_in_immutables
  TodoCard({
    required this.id,
    required this.title,
    required this.creationDate,
    required this.isChecked,
    required this.insertFunction,
    required this.deleteFunction,
    Key? key
  }) : super(key: key);

  @override
  TodocardState createState() => TodocardState();

}

class TodocardState extends State<TodoCard> {
  @override
  Widget build(BuildContext context) {
    var anotherTodo = Todo(
        id: widget.id,
        title: widget.title,
        creationDate: widget.creationDate,
        isChecked: widget.isChecked);

    return Card(
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Checkbox(
              value: widget.isChecked,
              onChanged: (bool? value) {
                setState(() {
                  widget.isChecked = value!;
                });
                anotherTodo.isChecked = value!;
                widget.insertFunction(anotherTodo);
              },
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  DateFormat('dd MMM yyyy - hh:mm aaa')
                      .format(widget.creationDate),
                  style: const TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    color: Color(0xFF8F8F8F),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () async {
              await showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text("Confirm task 'DELETE' submission?"),
                  content: const Text("Yes, I would like to confirm that this task should be deleted."),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                        widget.deleteFunction(anotherTodo);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                        color: Colors.redAccent),
                        child: const Text("confirm", style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              );
            },
            icon: const Icon(Icons.delete, color: Colors.grey),
          ),
        ],
      ),
    );
  }

}