import 'package:dio/dio.dart';

/// AlL the exceptions that can occur in the app are defined here.


///Getting the exception according to the error caught by DIO pkg
class DioExceptions implements Exception {
  DioExceptions.fromDioError({required DioError dioError}) {
    switch (dioError.type) {
      case DioErrorType.badCertificate:
        throw BadCertificateException();
      case DioErrorType.badResponse:
        throw BadResponseException();
      case DioErrorType.cancel:
        throw CancelException();
      case DioErrorType.connectionError:
        throw ConnectionException();
      case DioErrorType.connectionTimeout:
        throw ConnectionTimeoutException();
      case DioErrorType.receiveTimeout:
        throw ReceiveTimeoutException();
      case DioErrorType.sendTimeout:
        throw SentTimeoutException();
      default:
        throw NetworkException();
    }
  }
}

class NetworkException implements Exception {}

class BadResponseException implements Exception {}

class BadCertificateException implements Exception {}

class CancelException implements Exception {}

class ConnectionException implements Exception {}

class ConnectionTimeoutException implements Exception {}

class ReceiveTimeoutException implements Exception {}

class SentTimeoutException implements Exception {}

class UnknownException implements Exception {}
