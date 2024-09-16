import 'package:equatable/equatable.dart';

class ErrorMessageModel extends Equatable {
  final int? statusCode;
  final String? error;
  final String? message;

  const ErrorMessageModel({this.statusCode, this.error, this.message});

  factory ErrorMessageModel.fromJson(Map<String, dynamic> json) =>
      ErrorMessageModel(
          statusCode: json['statusCode'],
          error: json['error'],
          message: json['message']);

  @override
  List<Object?> get props => [statusCode, error, message];
}
