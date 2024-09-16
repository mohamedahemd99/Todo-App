import '../../domain/entities/auth.dart';

class AuthModel extends Auth {
  AuthModel(
      {required super.id,
      required super.accessToken,
      required super.refreshToken,
      required super.displayName});

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
      accessToken: json['access_token'] ?? "",
      id: json['_id'] ?? "",
      displayName: json['displayName'] ?? "",
      refreshToken: json['refresh_token'] ?? "");
}
