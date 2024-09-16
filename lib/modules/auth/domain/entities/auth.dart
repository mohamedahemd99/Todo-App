import 'package:equatable/equatable.dart';

class Auth extends Equatable {
  final String id;
  final String accessToken;
  final String refreshToken;
  final String displayName;

  Auth({
    required this.id,
    required this.accessToken,
    required this.refreshToken,
    required this.displayName,
  });

  @override
  List<Object?> get props => [id, accessToken, refreshToken, displayName];
}
