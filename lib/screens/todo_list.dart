import 'package:flutter/material.dart';
import 'package:todo_assignment2/models/database_model.dart';
import 'package:todo_assignment2/screens/todo_card.dart';

class Todolist extends StatelessWidget {

  final Function insertFunction;
  final Function deleteFunction;
  final db = DatabaseConnect();

  Todolist({
        required this.insertFunction,
        required this.deleteFunction,
        Key? key
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
        future: db.getTodo(),
        initialData: const [],
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          var data = snapshot.data;
          var dataLength = data!.length;
          return dataLength == 0
              ? const Center(child: Text('DATA not found...'),)
              : ListView.builder(
                  itemCount: dataLength,
                  itemBuilder: (context, counter) => TodoCard(
                    id: data[counter].id,
                    title: data[counter].title,
                    creationDate: data[counter].creationDate,
                    isChecked: data[counter].isChecked,
                    insertFunction: insertFunction,
                    deleteFunction: deleteFunction,
            ),
          );
        },
      ),
    );
  }
}