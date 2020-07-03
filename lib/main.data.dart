

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: directives_ordering

import 'dart:io';
import 'package:flutter_data/flutter_data.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'package:todos/models/user.dart';
import 'package:todos/models/todo.dart';

extension FlutterData on DataManager {

  static Future<DataManager> init(Directory baseDir, {bool autoManager = true, bool clear, bool remote, bool verbose, List<int> encryptionKey, Function(void Function<R>(R)) also}) async {
    assert(baseDir != null);

    final injection = DataServiceLocator();

    final manager = await DataManager(autoManager: autoManager).init(baseDir, injection.locator, clear: clear, verbose: verbose);
    injection.register(manager);

    final userRepository = $UserRepository(manager, remote: remote, verbose: verbose);
    injection.register<Repository<User>>(userRepository);
    final userBox = await Repository.getBox<User>(manager, encryptionKey: encryptionKey);
    injection.register(userBox);

    final todoRepository = $TodoRepository(manager, remote: remote, verbose: verbose);
    injection.register<Repository<Todo>>(todoRepository);
    final todoBox = await Repository.getBox<Todo>(manager, encryptionKey: encryptionKey);
    injection.register(todoBox);


    if (also != null) {
      // ignore: unnecessary_lambdas
      also(<R>(R obj) => injection.register<R>(obj));
    }
await userRepository.initialize();
await todoRepository.initialize();

    return manager;
  }
  
}



List<SingleChildWidget> dataProviders(Future<Directory> Function() directory, {bool clear, bool remote, bool verbose, List<int> encryptionKey}) => [
  FutureProvider<DataManager>(
    create: (_) => directory().then((dir) {
          return FlutterData.init(dir, clear: clear, remote: remote, verbose: verbose, encryptionKey: encryptionKey);
        })),


    ProxyProvider<DataManager, Repository<User>>(
      lazy: false,
      update: (_, m, __) => m?.locator<Repository<User>>(),
      dispose: (_, r) => r?.dispose(),
    ),


    ProxyProvider<DataManager, Repository<Todo>>(
      lazy: false,
      update: (_, m, __) => m?.locator<Repository<Todo>>(),
      dispose: (_, r) => r?.dispose(),
    ),];
