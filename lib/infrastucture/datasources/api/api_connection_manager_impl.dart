import 'package:dio/dio.dart';

import 'package:flutter_final_test/common/failure.dart';
import 'package:flutter_final_test/common/result.dart';

import 'api_connection_manager.dart';

class ApiConnectionManagerImpl extends IApiConnectionManager {
  final Dio _dio;

  ApiConnectionManagerImpl({required super.baseUrl})
      : _dio = Dio(BaseOptions(baseUrl: baseUrl));

  @override
  Future<Result<T>> request<T>(
      String path, String method, T Function(dynamic) mapper,
      {dynamic body, Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.request(path,
          data: body,
          options: Options(method: method),
          queryParameters: queryParameters);

      return Result<T>(value: mapper(response.data));
    } on DioException catch (e) {
      return Result(failure: handleException(e));
    } catch (e) {
      return Result(failure: const UnknownFailure());
    }
  }

  Failure handleException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout ||
            DioExceptionType.sendTimeout ||
            DioExceptionType.receiveTimeout ||
            DioExceptionType.connectionError:
        return const NoInternetFailure();
      case DioExceptionType.badResponse:
        return NoAuthorizeFailure(message: e.message!);
      default:
        return const UnknownFailure();
    }
  }

  @override
  void setHeaders(String key, dynamic value) =>
      _dio.options.headers[key] = value;
}
