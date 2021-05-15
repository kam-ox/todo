import 'package:flutter/material.dart';

void main() => runApp(TodoApp());

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.orange,
        accentColor: Colors.orange.shade300,
        primaryIconTheme: IconThemeData(color: Colors.white),
        appBarTheme: AppBarTheme(
          centerTitle: true,
          elevation: 8,
          textTheme: TextTheme(
            title: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic),
          ),
        ),
      ),
      title: 'Todo List',
      home: new TodoList(),
    );
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
    return Card(
      shape: RoundedRectangleBorder(
        // adding rounded corners
        borderRadius: BorderRadius.circular(12), // use circular, not all
      ),
      elevation: 3,
      margin: EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 8,
      ),
      child: ListTile(
        subtitle: Text('Tap to mark as done'),
        title: Text(todoText),
        onTap: () => _promptRemoveTodoItem(index),
        trailing: IconButton(
          icon: Icon(
            Icons.done_all_rounded,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
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
        child: Icon(
          Icons.add,
          color: Theme.of(context).primaryIconTheme.color,
        ),
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
              hintText: 'What to do?',
              contentPadding: EdgeInsets.all(16),
            ),
          ));
    }));
  }
}
