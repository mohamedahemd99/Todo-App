import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel(
      {required super.id,
      required super.displayName,
      required super.username,
      required super.roles,
      required super.active,
      required super.experienceYears,
      required super.address,
      required super.level,
      required super.createdAt,
      required super.updatedAt,
      required super.v});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['_id'] as String,
        displayName: json['displayName'] as String,
        username: json['username'] as String,
        roles:
            (json['roles'] as List<dynamic>).map((e) => e as String).toList(),
        active: json['active'] as bool,
        experienceYears: (json['experienceYears'] as num).toInt(),
        address: json['address'] as String,
        level: json['level'] as String,
        createdAt: json['createdAt'] as String,
        updatedAt: json['updatedAt'] as String,
        v: (json['__v'] as num).toInt(),
      );
}
