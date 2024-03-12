import 'package:flutter/cupertino.dart';
import 'package:to_do/model/todo.dart';
import 'package:flutter/material.dart';
import 'package:to_do/widget/to_item.dart';

class Home extends StatefulWidget{
   Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todolist = ToDo.todoList();
  final _toDoController = TextEditingController();
  List<ToDo>_foundToDo = [];

  @override
  void initState() {
    _foundToDo = todolist;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow.shade100,
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade100,
        elevation: 0,
        title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
          Icon(
            Icons.menu,
            color: Colors.black87,
            size: 30,
          ),
          Container(
            height: 40,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset('assets/images/user.jpg'),
            ),
          )
        ]),
      ),
      body: Stack(
        children:[ Container(
          padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15),
          child: Column(
            children: [
              searchBox(),
              Expanded(
                child: ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        top: 50,
                        bottom: 20,
                      ),
                      child: Text('All ToDo', style: TextStyle(fontSize: 30,
                          fontWeight: FontWeight.w500),),
                    ),

                    for( ToDo todo in _foundToDo.reversed)
                    ToDoItem(
                      todo: todo,
                      onToDochanged: _handletoDochange,
                      onDeleteItem: _handletoDoDelete,
                    ),

                  ],
                ),
              )
            ],
          )
        ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(children: [
              Expanded(child: Container(
                margin: EdgeInsets.only(
                  bottom: 20,
                  right: 20,
                  left: 20,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 5
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.grey, offset: Offset(0.0,0.0),
                    blurRadius: 10.0,
                    spreadRadius: 0.0,
                  ),],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: _toDoController,
                  decoration: InputDecoration(
                    hintText: 'Add a New ToDo item',
                    border: InputBorder.none
                  ),
                ),
              )),
              Container(
                margin: EdgeInsets.only(
                  bottom: 20,
                  right: 20,
                ),
                child: ElevatedButton(
                  child: Text('+', style: TextStyle(fontSize: 40, color: Colors.white),),
                  onPressed: (){
                    _addToDoItem(_toDoController.text);
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(60, 60),
                    backgroundColor: Colors.blue,
                    elevation: 10,
                  ),
                ),
              ),
            ],),
          )
    ],
      ),
    );
  }
  void _handletoDochange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });

  }

  void _handletoDoDelete(String id) {
    setState(() {
      todolist.removeWhere((item) => item.id == id);
    });
  }

  void _addToDoItem(String toDo){
    setState(() {
      todolist.add(ToDo(id: DateTime.now().millisecondsSinceEpoch.toString(),
          todoText: toDo));
    });
    _toDoController.clear();
  }

  void _RunFilter(String enteredkeyword){
    List<ToDo> result = [];
    if(enteredkeyword.isEmpty){
      result = todolist;
    }else{
      result = todolist.where((item) => item.todoText!
          .toLowerCase().contains(enteredkeyword
          .toLowerCase())).toList();
    }

    setState(() {
      _foundToDo = result;
    });
  }

  Widget searchBox(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20)
      ),
      child: TextField(
        onChanged: (value) => _RunFilter(value),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(0),
            prefixIcon: Icon(Icons.search),
            prefixIconConstraints: BoxConstraints(
                maxHeight: 20,
                maxWidth: 25
            ),
            border:InputBorder.none,
            hintText: 'Search',
            hintStyle: TextStyle(color: Colors.grey)
        ),
      ),
    );
  }
}




