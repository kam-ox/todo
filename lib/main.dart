import 'package:flutter/material.dart';

void main() => runApp(TodoApp());

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(title: 'Todo List', home: new TodoList());
  }
}

class TodoList extends StatefulWidget {
  @override
  createState() => new _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<String> _todoItems = [];

  // void _addTodoItem() {
  //   setState(() {
  //     int index = _todoItems.length;
  //     _todoItems.add('Item ' + index.toString());
  //   });
  // }

  Widget _buildTodoList() {
    return ListView.builder(itemBuilder: (ctx, index) {
      if (index < _todoItems.length) {
        return _buildTodoItem(_todoItems[index], index);
      }
    });
  }

  Widget _buildTodoItem(String todoText, int index) {
    return new ListTile(
      title: new Text(todoText),
      onTap: () => _promptRemoveTodoItem(index),
    );
  }

  void _addTodoItem(String task) {
    if (task.length > 0) {
      setState(() => _todoItems.add(task));
    }
  }

  void _removeTodoItem(int index) {
    setState(() {
      _todoItems.removeAt(index);
    });
  }

  void _promptRemoveTodoItem(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Mark ${_todoItems[index]} as done?'),
            actions: [
              FlatButton(
                  onPressed: Navigator.of(context).pop, child: Text('CANCEL')),
              FlatButton(
                onPressed: () {
                  _removeTodoItem(index);
                  Navigator.of(context).pop();
                },
                child: Text('MARK AS DONE'),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: _buildTodoList(),
      floatingActionButton: FloatingActionButton(
        onPressed: _pushAddTodoScreen,
        tooltip: 'Add task',
        child: Icon(Icons.add),
      ),
    );
  }

  void _pushAddTodoScreen() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return Scaffold(
          appBar: AppBar(
            title: Text('Add a new task'),
          ),
          body: TextField(
            autofocus: true,
            onSubmitted: (val) {
              _addTodoItem(val);
              Navigator.pop(context);
            },
            decoration: InputDecoration(
              hintText: 'What you want to do?',
              contentPadding: EdgeInsets.all(16),
            ),
          ));
    }));
  }
}
