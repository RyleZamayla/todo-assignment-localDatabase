import 'package:flutter/material.dart';
import 'package:todo_assignment2/models/database_model.dart';
import 'package:todo_assignment2/screens/todo_card.dart';
import 'package:lottie/lottie.dart';

class Todolist extends StatelessWidget {

  final Function updateFunction;
  final Function insertFunction;
  final Function deleteFunction;
  final db = DatabaseConnect();

  Todolist({
    required this.updateFunction,
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
              ? Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset("assets/116072-socialv-no-data.json", height: 200),
                  const Text('No data to Display.',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 24)
                  ),
                ],
              ))
              : ListView.builder(
                  itemCount: dataLength,
                  itemBuilder: (context, counter) => TodoCard(
                    key: Key(data[counter].id.toString()),
                    id: data[counter].id,
                    title: data[counter].title,
                    creationDate: data[counter].creationDate,
                    isChecked: data[counter].isChecked,
                    insertFunction: insertFunction,
                    updateFunction: updateFunction,
                    deleteFunction: deleteFunction,
            ),
          );
        },
      ),
    );
  }
}