import 'package:dio/dio.dart';
import 'package:happy_tech_mastering_api_with_flutter/core/error/error_model.dart';

class ServerExecptions implements Exception {
  final ErrorModel errorModel;

  ServerExecptions({
    required this.errorModel,
  });
}

void handleException(DioException e) {
  switch (e.type) {
    //! Request Not Arrive to Database
    case DioExceptionType.connectionTimeout:
      throw ServerExecptions(errorModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.sendTimeout:
      throw ServerExecptions(errorModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.receiveTimeout:
      throw ServerExecptions(errorModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.badCertificate:
      throw ServerExecptions(errorModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.cancel:
      throw ServerExecptions(errorModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.connectionError:
      throw ServerExecptions(errorModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.unknown:
      throw ServerExecptions(errorModel: ErrorModel.fromJson(e.response!.data));

    //! Request Arrive to Database but data is not corect

    case DioExceptionType.badResponse:
      switch (e.response?.statusCode) {
        //!Bad Request
        case 400:
          throw ServerExecptions(
              errorModel: ErrorModel.fromJson(e.response!.data));
        //! unauthorized
        case 401:
          throw ServerExecptions(
              errorModel: ErrorModel.fromJson(e.response!.data));
        //! Forbidden
        case 403:
          throw ServerExecptions(
              errorModel: ErrorModel.fromJson(e.response!.data));
        //! Not Found
        case 404:
          throw ServerExecptions(
              errorModel: ErrorModel.fromJson(e.response!.data));
        //! Cofficient
        case 409:
          throw ServerExecptions(
              errorModel: ErrorModel.fromJson(e.response!.data));
        //! unprocessable Entity
        case 422:
          throw ServerExecptions(
              errorModel: ErrorModel.fromJson(e.response!.data));
        //! Server Exception
        case 504:
          throw ServerExecptions(
              errorModel: ErrorModel.fromJson(e.response!.data));
      }
  }
}
