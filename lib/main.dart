import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_data/flutter_data.dart';
import 'package:flutter_data_state/flutter_data_state.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:todos/main.data.dart';

import 'models/todo.dart';
import 'models/user.dart';

main() {
  runApp(MultiProvider(
    providers: [
      ...dataProviders(() => getApplicationDocumentsDirectory(), clear: true),
    ],
    child: TodoApp(),
  ));
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Builder(
            builder: (context) {
              if (context.watch<DataManager>() == null) {
                return const CircularProgressIndicator();
              }
              return TodoScreen();
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final user = await context
                .read<Repository<User>>()
                .findOne('1', remote: false);

            final todo = Todo(
                title: "Task number ${Random().nextInt(9999)}",
                user: BelongsTo());

            // await todo.save();
            user.todos.add(todo);
          },
          child: Icon(Icons.add),
        ),
      ),
      theme: theme,
      debugShowCheckedModeBanner: false,
    );
  }
}

class TodoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final repository = context.watch<Repository<User>>();
    return DataStateBuilder<User>(
      notifier: repository.watchOne(
        1,
        params: {'_embed': 'todos'},
        alsoWatch: (u) => [u.todos],
      ),
      builder: (context, state, notifier, _) {
        if (state.hasException) {
          return Text(state.exception.toString());
        }
        return TodoList(state);
      },
    );
  }
}

class TodoList extends StatelessWidget {
  final DataState<User> state;
  final List<Todo> todos;
  TodoList(this.state, {Key key})
      : todos = state.model?.todos?.toList(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (state.isLoading) {
      return Center(child: const CircularProgressIndicator());
    }
    return ListView.separated(
      itemBuilder: (context, i) {
        final todo = todos[i];
        return GestureDetector(
          onDoubleTap: () async {
            final user = await context
                .read<Repository<User>>()
                .findOne('1', remote: false);
            if (todo.id != null) {
              Todo(
                id: todo.id,
                title: todo.title,
                completed: !todo.completed,
                user: user.asBelongsTo,
              ).save();
            }
          },
          child: Dismissible(
            child: Text(
              '''${todo.completed ? "✅" : "◻️"} (${todos.length})
              [id: ${todo.id} / ${keyFor(todo)}] ${todo.title}
              / u: ${todo.user?.value?.id} / ${todo.hashCode}''',
              style: TextStyle(color: Colors.black87),
            ),
            key: ValueKey(todo),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              child: Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (_) async {
              await todo.delete();
            },
          ),
        );
      },
      itemCount: todos.length,
      separatorBuilder: (context, i) => Divider(),
      padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
    );
  }
}

final theme = ThemeData.light().copyWith(
  textTheme: GoogleFonts.interTextTheme(
    TextTheme(
      bodyText1: TextStyle(
        fontSize: 16,
        color: Colors.blueGrey[800],
      ),
    ),
  ),
);
