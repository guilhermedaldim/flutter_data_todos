

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: directives_ordering, top_level_function_literal_block

import 'package:flutter_data/flutter_data.dart';

import 'package:path_provider/path_provider.dart';


import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:todos/models/user.dart';
import 'package:todos/models/todo.dart';

ConfigureRepositoryLocalStorage configureRepositoryLocalStorage = ({FutureFn<String> baseDirFn, List<int> encryptionKey, bool clear}) {
  // ignore: unnecessary_statements
  baseDirFn ??= () => getApplicationDocumentsDirectory().then((dir) => dir.path);
  return hiveLocalStorageProvider.overrideAs(RiverpodAlias.provider(
        (_) => HiveLocalStorage(baseDirFn: baseDirFn, encryptionKey: encryptionKey, clear: clear)));
};

RepositoryInitializerProvider repositoryInitializerProvider = (
        {bool remote, bool verbose}) {
      internalLocatorFn = (provider, context) => provider.read(context);
    
  return _repositoryInitializerProviderFamily(
      RepositoryInitializerArgs(remote, verbose));
};

final _repositoryInitializerProviderFamily =
  RiverpodAlias.futureProviderFamily<RepositoryInitializer, RepositoryInitializerArgs>((ref, args) async {
    final graphs = <String, Map<String, RemoteAdapter>>{'todos,users': {'todos': ref.read(todoRemoteAdapterProvider), 'users': ref.read(userRemoteAdapterProvider)}};
                await ref.read(userRepositoryProvider).initialize(
              remote: args?.remote,
              verbose: args?.verbose,
              adapters: graphs['todos,users'],
              ref: ref,
            );            await ref.read(todoRepositoryProvider).initialize(
              remote: args?.remote,
              verbose: args?.verbose,
              adapters: graphs['todos,users'],
              ref: ref,
            );
    return RepositoryInitializer();
});




