import 'package:flutter/material.dart';

class Failure {
  const Failure([String? errorMessage]) : _errorMessage = errorMessage;

  final String? _errorMessage;

  /// Message to display for user
  String get errorMessage => _errorMessage?.isNotEmpty ?? false
      ? _errorMessage!
      : "Something went wrong";

  factory Failure.from(
    Object e,
    StackTrace? stack,
  ) {
    debugPrint('$e${stack == null ? '' : '\n$stack'}');

    // if (e is ApiException) return Failure(e.message);
    return const Failure();
  }
}

class AllRight extends Failure {
  const AllRight() : super('');

  @override
  String get errorMessage => '';
}
