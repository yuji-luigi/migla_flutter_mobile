import 'package:migla_flutter/src/models/internal/logger.dart';

class ApiError {
  final String message;
  final String? field;

  ApiError({required this.message, this.field});

  factory ApiError.fromJson(Map<String, dynamic> json) {
    try {
      print(json);
      return ApiError(
        message: json['message'],
        field: json['field'],
      );
    } catch (error, stackTrace) {
      Logger.error(stackTrace.toString());
      Logger.error(error.toString());
      rethrow;
    }
  }
}
