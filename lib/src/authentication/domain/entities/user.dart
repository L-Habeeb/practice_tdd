import 'package:equatable/equatable.dart';


class User extends Equatable{
  final int id;
  final String createdAt;
  final String avatar;
  final String name;

  const User({
    required this.name,
    required this.id,
    required this.createdAt,
    required this.avatar,
  });

  @override
  List<Object?> get props => [id];
}
