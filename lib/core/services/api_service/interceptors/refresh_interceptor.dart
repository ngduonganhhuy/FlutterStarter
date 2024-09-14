import 'package:dio/dio.dart';
import 'package:aes_room/core/error/exception.dart';
import 'package:aes_room/core/services/api_service/api_service.dart';
import 'package:aes_room/core/utils/logout_helper.dart';

class RefreshInterceptor extends QueuedInterceptor {
  RefreshInterceptor();

  void handleRefreshTokenFailed(DioException err, ErrorInterceptorHandler handler) {
    LogoutHelper.handleLogout();
    handler.reject(err);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    final dioResponse = err.response;
    final requestOptions = err.response?.requestOptions;
    if (requestOptions != null && dioResponse?.statusCode == ApiStatusCode.Unauthorized) {
      final shouldCheckRefreshToken = requestOptions.extra['shouldCheckRefreshToken'] as bool? ?? true;
      if (shouldCheckRefreshToken) {
        if (ApiService.token.isEmpty) {
          handler.reject(err);
          return;
        }
        if (requestOptions.headers['Authorization'] == 'Bearer ${ApiService.token}') {
          //TODO Handle refresh token
        } else {
          await recallApi(requestOptions).then((value) => handler.resolve(value)).onError((error, stackTrace) => handler.reject(err));
        }
      }
    } else {
      handler.reject(err);
    }
  }

  Future<Response<dynamic>> recallApi(RequestOptions requestOptions) async {
    requestOptions.headers.addAll(ApiService.getHeader());
    final opts = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
      contentType: Headers.jsonContentType,
    );
    final response = await ApiService.refreshTokenDio.request<dynamic>(
      requestOptions.path,
      options: opts,
      cancelToken: requestOptions.cancelToken,
      onReceiveProgress: requestOptions.onReceiveProgress,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
    );
    return response;
  }
}
