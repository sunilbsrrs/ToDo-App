//import 'dart:html';

class ToDo{
  String? id;
  String? todoText;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
});

  static List<ToDo> todoList(){
    return[
      ToDo(id: '01', todoText: 'Morning Exercise', isDone: true),
      ToDo(id: '02', todoText: 'Buy Grocerries', isDone: true),
      ToDo(id: '03', todoText: 'Check Mail', ),
      ToDo(id: '04', todoText: 'Team Meating' ),
      ToDo(id: '05', todoText: 'Work on Mobile apps for 3 hrors',),
      ToDo(id: '06', todoText: 'Dinner with Anand',),
    ];
  }
}