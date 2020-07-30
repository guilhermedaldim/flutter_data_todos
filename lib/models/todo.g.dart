// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Todo _$TodoFromJson(Map<String, dynamic> json) {
  return Todo(
    id: json['id'] as int,
    title: json['title'] as String,
    completed: json['completed'] as bool,
    user: json['user'] == null
        ? null
        : BelongsTo.fromJson(json['user'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$TodoToJson(Todo instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'completed': instance.completed,
      'user': instance.user,
    };

// **************************************************************************
// RepositoryGenerator
// **************************************************************************

// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member, non_constant_identifier_names

mixin $TodoLocalAdapter on LocalAdapter<Todo> {
  @override
  Map<String, Map<String, Object>> relationshipsFor([Todo model]) => {
        'user': {
          'inverse': 'todos',
          'type': 'users',
          'kind': 'BelongsTo',
          'instance': model?.user
        }
      };

  @override
  Todo deserialize(map) {
    for (final key in relationshipsFor().keys) {
      map[key] = {
        '_': [map[key], !map.containsKey(key)],
      };
    }
    return _$TodoFromJson(map);
  }

  @override
  Map<String, dynamic> serialize(model) => _$TodoToJson(model);
}

// ignore: must_be_immutable
class $TodoHiveLocalAdapter = HiveLocalAdapter<Todo> with $TodoLocalAdapter;

class $TodoRemoteAdapter = RemoteAdapter<Todo>
    with JSONPlaceholderAdapter<Todo>;

//

final todoLocalAdapterProvider = RiverpodAlias.provider<LocalAdapter<Todo>>(
    (ref) => $TodoHiveLocalAdapter(
        ref.read(hiveLocalStorageProvider), ref.read(graphProvider)));

final todoRemoteAdapterProvider = RiverpodAlias.provider<RemoteAdapter<Todo>>(
    (ref) => $TodoRemoteAdapter(ref.read(todoLocalAdapterProvider)));

final todoRepositoryProvider =
    RiverpodAlias.provider<Repository<Todo>>((_) => Repository<Todo>());

extension TodoX on Todo {
  Todo init(context) {
    return internalLocatorFn(todoRepositoryProvider, context)
        .internalAdapter
        .initializeModel(this, save: true) as Todo;
  }
}
