import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_assignment2/models/todos_model_LocalDB.dart';

// ignore: must_be_immutable
class TodoCard extends StatefulWidget {

  final int id;
  final String title;
  final DateTime creationDate;
  late final bool isChecked;
  final Function updateFunction;
  final Function insertFunction;
  final Function deleteFunction;
  // ignore: prefer_const_constructors_in_immutables
  TodoCard({
    required this.id,
    required this.title,
    required this.creationDate,
    required this.isChecked,
    required this.updateFunction,
    required this.insertFunction,
    required this.deleteFunction,
    Key? key
  }) : super(key: key);

  @override
  TodocardState createState() => TodocardState();

}

class TodocardState extends State<TodoCard> {

  TextEditingController todoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    todoController.text = widget.title;
  }

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
              onChanged: (bool? value) async {
                if(widget.isChecked == false){
                  await showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text("Confirm task [ COMPLETED ] submission?"),
                      content: const Text("Yes, I would like to confirm that this task has been completed"),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            if (widget.isChecked == false){
                              setState(() {
                                widget.isChecked = value!;
                              });
                            }
                            else{
                              setState(() {

                              });
                            }
                            Navigator.of(ctx).pop();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                color: Colors.green),
                            child: const Text("confirm", style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                else{
                  await showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text("Confirm task [ NOT COMPLETED ] submission?"),
                      content: const Text("Yes, I would like to confirm that this task has not been completed"),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            if (widget.isChecked == true){
                              setState(() {
                                widget.isChecked = value!;
                              });
                            }
                            else{
                              setState(() {

                              });
                            }
                            Navigator.of(ctx).pop();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                color: Colors.green),
                            child: const Text("confirm", style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  );
                }
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
              await showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(25.0),
                    ),
                  ),
                  backgroundColor: Colors.white, // <-- SEE HERE
                  builder: (context) => Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Center(
                              child: ListView(
                                shrinkWrap: true,
                                padding: const EdgeInsets.all(25),
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        border: Border.all(color: Colors.white),
                                        borderRadius: BorderRadius.circular(10)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: TextFormField(
                                        autofocus: true,
                                        controller: todoController,
                                        maxLines: 3,
                                        keyboardType: TextInputType.name,
                                        style: const TextStyle(
                                          fontSize: 18,
                                        ),
                                        decoration: const InputDecoration(
                                          labelText: "Edit a Task:",
                                          suffixIcon: Padding(
                                            padding: EdgeInsets.only(top: 15), // add padding to adjust icon
                                            child: Icon(Icons.check_circle_outlined),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    height: 50,
                                    child: ElevatedButton(
                                      style:ElevatedButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor: Colors.lightBlueAccent, // foreground
                                      ),
                                      onPressed: () {
                                        print("${anotherTodo.id}, ${anotherTodo.title}");
                                        setState(() {
                                           widget.updateFunction(anotherTodo.id, anotherTodo.title);
                                        });
                                      },
                                      child: const Text("Update Task",
                                        style:
                                        TextStyle(fontSize: 15),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            )
                          ],
                        ),
                      ),
                    )
                  );
            },
            icon: const Icon(Icons.edit, color: Colors.grey),
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
          )
        ],
      ),
    );
  }
}