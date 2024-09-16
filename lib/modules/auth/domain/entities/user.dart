import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String displayName;
  final String username;
  final List<String> roles;
  final bool active;
  final int experienceYears;
  final String address;
  final String level;
  final String createdAt;
  final String updatedAt;
  final int v;

  User({
    required this.id,
    required this.displayName,
    required this.username,
    required this.roles,
    required this.active,
    required this.experienceYears,
    required this.address,
    required this.level,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  @override
  List<Object?> get props => [
        id,
        displayName,
        username,
        roles,
        active,
        experienceYears,
        address,
        level,
        createdAt,
        updatedAt,
        v
      ];
}
