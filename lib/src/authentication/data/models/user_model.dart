import 'dart:convert';

import 'package:practice_tdd/core/utils/typedef.dart';
import 'package:practice_tdd/src/authentication/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.name,
    required super.id,
    required super.createdAt,
    required super.avatar,
  });

  const UserModel.empty()
    : this(
        id: '1',
        createdAt: '_empty.createdAt',
        name: '_empty.name',
        avatar: '_empty.avatar',
      );

  UserModel copyWith({
    String? id,
    String? createdAt,
    String? avatar,
    String? name,
  }) {
    return UserModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      avatar: avatar ?? this.avatar,
      name: name ?? this.name,
    );
  }

  factory UserModel.fromMap(DataMap map) {
    return UserModel(
      id: map['id'] as String? ?? '',
      createdAt: map['createdAt'] as String? ?? '',
      avatar: map['avatar'] as String? ?? '',
      name: map['name'] as String? ?? '',
    );
  }

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(jsonDecode(source) as DataMap);

  DataMap toMap() {
    return {'id': id, 'createdAt': createdAt, 'avatar': avatar, 'name': name};
  }

  String toJson() => json.encode(toMap());
}

  // factory UserModel.fromJson(String source) =>
  //     UserModel.fromMap(json.decode(source));
  // factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as DataMap);

  // Map<String, dynamic> toMap() {
  //   return {'id': id, 'createdAt': createdAt, 'avatar': avatar, 'name': name};
  // }

  // factory UserModel.fromMap(Map<String, dynamic> map) {
  //   return UserModel(
  //     id: map['id'] ?? '',
  //     createdAt: map['createdAt'] ?? '',
  //     avatar: map['avatar'] ?? '',
  //     name: map['name'] ?? '',
  //   );
  // }

  // String toJson() => json.encode(toMap());

  // DataMap toMap() => {
  //   id: id,
  //   createdAt: createdAt,
  //   avatar: avatar,
  //   name: name,
  // };

  // @override
  // String toString() {
  //   return 'User(id: $id, createdAt: $createdAt, avatar: $avatar, name: $name)';
  // }
