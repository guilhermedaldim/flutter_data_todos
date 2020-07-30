// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    id: json['id'] as int,
    name: json['name'] as String,
    todos: json['todos'] == null
        ? null
        : HasMany.fromJson(json['todos'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'todos': instance.todos,
    };

// **************************************************************************
// RepositoryGenerator
// **************************************************************************

// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member, non_constant_identifier_names

mixin $UserLocalAdapter on LocalAdapter<User> {
  @override
  Map<String, Map<String, Object>> relationshipsFor([User model]) => {
        'todos': {
          'inverse': 'user',
          'type': 'todos',
          'kind': 'HasMany',
          'instance': model?.todos
        }
      };

  @override
  User deserialize(map) {
    for (final key in relationshipsFor().keys) {
      map[key] = {
        '_': [map[key], !map.containsKey(key)],
      };
    }
    return _$UserFromJson(map);
  }

  @override
  Map<String, dynamic> serialize(model) => _$UserToJson(model);
}

// ignore: must_be_immutable
class $UserHiveLocalAdapter = HiveLocalAdapter<User> with $UserLocalAdapter;

class $UserRemoteAdapter = RemoteAdapter<User>
    with JSONPlaceholderAdapter<User>;

//

final userLocalAdapterProvider = RiverpodAlias.provider<LocalAdapter<User>>(
    (ref) => $UserHiveLocalAdapter(
        ref.read(hiveLocalStorageProvider), ref.read(graphProvider)));

final userRemoteAdapterProvider = RiverpodAlias.provider<RemoteAdapter<User>>(
    (ref) => $UserRemoteAdapter(ref.read(userLocalAdapterProvider)));

final userRepositoryProvider =
    RiverpodAlias.provider<Repository<User>>((_) => Repository<User>());

extension UserX on User {
  User init(context) {
    return internalLocatorFn(userRepositoryProvider, context)
        .internalAdapter
        .initializeModel(this, save: true) as User;
  }
}
