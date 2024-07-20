import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../constants/constants.dart';
import '../error/failure.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: "https://api.itbook.store/1.0",
    headers: {
      // 'Authorization': 'Bearer your_token_here',
      'Content-Type': 'application/json'
    },
    receiveDataWhenStatusError: true,
    connectTimeout: const Duration(milliseconds: Constants.connectTimeout),
    receiveTimeout: const Duration(milliseconds: Constants.receiveTimeout),
  ));

  ApiService() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        debugPrint('Request: ${options.method} ${options.path}');
        return handler.next(options);
      },
      onResponse: (response, handler) {
        debugPrint('Response: ${response.statusCode} ${response.data}');
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        debugPrint('Error: ${e.response?.statusCode} ${e.message}');
        return handler.next(e);
      },
    ));
  }

  Future<Response> getRequest(String endpoint,
      {Map<String, dynamic>? headers, Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.get(endpoint,
          options: Options(headers: headers), queryParameters: data);
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> postRequest(String endpoint,
      {Map<String, dynamic>? headers, Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.post(endpoint,
          options: Options(headers: headers), data: data);
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Failure _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.cancel:
        return const NetworkFailure('Request to API server was cancelled');
      case DioExceptionType.connectionTimeout:
        return const NetworkFailure('Connection timeout with API server');
      case DioExceptionType.receiveTimeout:
        return const NetworkFailure(
            'Receive timeout in connection with API server');
      case DioExceptionType.sendTimeout:
        return const NetworkFailure(
            'Send timeout in connection with API server');
      case DioExceptionType.badResponse:
        return ServerFailure(
            'Received invalid status code: ${error.response?.statusCode}');
      case DioExceptionType.connectionError:
        return const NetworkFailure(
            'Connection to API server failed due to internet connection');
      case DioExceptionType.unknown:
        return UnexpectedFailure('Unexpected error occurred: $error');
      default:
        return const UnexpectedFailure('Something went wrong');
    }
  }
}
