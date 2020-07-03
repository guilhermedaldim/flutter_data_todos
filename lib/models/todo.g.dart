// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// DataGenerator
// **************************************************************************

// ignore_for_file: unused_local_variable, always_declare_return_types, non_constant_identifier_names
mixin _$TodoModelAdapter on Repository<Todo> {
  @override
  Map<String, Map<String, Object>> relationshipsFor([Todo model]) => {
        'user': {'type': 'users', 'kind': 'BelongsTo', 'instance': model?.user}
      };

  @override
  Map<String, Repository> get relatedRepositories =>
      {'users': manager.locator<Repository<User>>()};

  @override
  localDeserialize(map) {
    for (final key in relationshipsFor().keys) {
      map[key] = {
        '_': [map[key], !map.containsKey(key), manager]
      };
    }
    return _$TodoFromJson(map);
  }

  @override
  localSerialize(model) {
    final map = _$TodoToJson(model);
    for (final e in relationshipsFor(model).entries) {
      map[e.key] = (e.value['instance'] as Relationship)?.toJson();
    }
    return map;
  }
}

class $TodoRepository = Repository<Todo>
    with
        _$TodoModelAdapter,
        RemoteAdapter<Todo>,
        WatchAdapter<Todo>,
        JSONPlaceholderAdapter<Todo>;

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
