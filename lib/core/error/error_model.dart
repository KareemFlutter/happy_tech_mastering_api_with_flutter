import 'package:happy_tech_mastering_api_with_flutter/core/api/end_ponits.dart';

class ErrorModel {
  final String errorMessage;
  final int statusCode;

  ErrorModel({
    required this.errorMessage,
    required this.statusCode,
  });

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(
      errorMessage: json[ApiKeys.status],
      statusCode: json[ApiKeys.errorMessage],
    );
  }
}
