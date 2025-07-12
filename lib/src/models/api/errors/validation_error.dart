import 'package:migla_flutter/src/models/internal/logger.dart';

class ValidationError {
  final String path;
  final String message;

  ValidationError({required this.path, required this.message});

  factory ValidationError.fromJson(Map<String, dynamic> json) {
    try {
      return ValidationError(
        path: json['path'],
        message: json['message'],
      );
    } catch (error, stackTrace) {
      Logger.error(stackTrace.toString());
      Logger.error(error.toString());
      rethrow;
    }
  }
}
