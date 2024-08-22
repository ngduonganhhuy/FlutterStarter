import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_stater/core/constants/app_constants.dart';
import 'package:flutter_stater/core/error/exception.dart';
import 'package:flutter_stater/core/services/api_service/interceptors/debug_interceptor.dart';
import 'package:flutter_stater/core/services/api_service/interceptors/encoding_params_interceptor.dart';
import 'package:flutter_stater/core/services/api_service/interceptors/refresh_interceptor.dart';
import 'package:flutter_stater/core/utils/logger.dart';
import 'package:flutter_stater/core/utils/logout_helper.dart';
import 'package:flutter_stater/core/utils/path_helper.dart';
import 'package:flutter_stater/core/utils/utils.dart';

enum RequestMethod { NONE, GET, POST, PATCH, PUT, DELETE, DOWNLOAD }

enum SortType { NONE, ASC, DESC }

class ApiService {
  static const int _timeout = 60;
  static const String _userAgent = 'flutter_clean_architecture';
  static String token = '';
  static CancelToken _cancelToken = CancelToken();

  static final Dio _dio = Dio(BaseOptions(connectTimeout: const Duration(seconds: _timeout), baseUrl: AppConstants.baseUrl))
    ..interceptors.add(EncodingParamsInterceptor())
    ..interceptors.add(AppConstants.isDev ? DebugInterceptor(printOnSuccess: true) : const Interceptor())
    ..interceptors.add(RefreshInterceptor());

  static final Dio refreshTokenDio = Dio(BaseOptions(baseUrl: AppConstants.baseUrl))
    ..interceptors.add(EncodingParamsInterceptor())
    ..interceptors.add(kDebugMode ? DebugInterceptor(printOnSuccess: true) : const Interceptor());

  static String get getUserAgent => _userAgent;

  static void setToken({required String? newToken}) {
    if (!Utils.isNullOrEmpty(newToken)) {
      token = newToken ?? '';
    }
  }

  static bool hasToken() {
    return !Utils.isNullOrEmpty(token);
  }

  static void clearToken() {
    token = '';
  }

  // ------------------------- Base -------------------------
  static Map<String, String?> getHeader() {
    return {
      'User-Agent': _userAgent,
      if (Utils.isNotNullOrEmpty(token)) 'Authorization': 'Bearer $token',
    };
  }

  static String getSavePath(Headers headers) {
    var fileName = headers.value('content-disposition')?.split('filename=')[1];
    if (fileName == null) {
      fileName = headers.value('uri')?.split('/').last;
      if (fileName == null) {
        throw ApiException(error: ApiErrorMessage.DOWNLOAD_CANT_GET_FILENAME_ERROR);
      }
    }
    final savePath = '${PathHelper.storeDownloadFilesPath}/$fileName';
    return savePath;
  }

  static Future<dynamic> callRequest(
    RequestMethod method,
    String url,
    String apiDescription, {
    Dio? dio,
    Map<String, dynamic>? params,
    Object? body,
    bool shouldCheckRefreshToken = true,
  }) async {
    if (_cancelToken.isCancelled) {
      _cancelToken = CancelToken();
    }
    try {
      Utils.logWithBreakLine('start $apiDescription');
      final options = Options(
        method: Utils.enumToString(method),
        headers: getHeader(),
        contentType: Headers.jsonContentType,
        extra: {
          'name': apiDescription,
          'request_time': Utils.convertDateTimeToPatternTime(DateTime.now(), pattern: 'hh:mm:ss a'),
          'shouldCheckRefreshToken': shouldCheckRefreshToken,
        },
      );
      if (method == RequestMethod.DOWNLOAD) {
        options.method = null;
        final res = await _dio.download(
          url,
          getSavePath,
          queryParameters: params,
          options: options,
        );
        final savePath = getSavePath(res.headers);
        return savePath;
      } else {
        final response = await (dio ?? _dio).request<dynamic>(
          url,
          queryParameters: params,
          data: body,
          options: options,
          cancelToken: _cancelToken,
        );
        if (response.data == null) throw NullException();
        return response.data;
      }
    } on DioException catch (error) {
      _handelDioError(url, error);
    } catch (e) {
      throw ApiException(error: ApiErrorMessage.APP_API_ERROR);
    }
  }

  static void _handelDioError(String url, DioException error) {
    final dioResponse = error.response;
    if (dioResponse != null) {
      AppLogger.d('API FAIL 1 - $url - ${dioResponse.statusCode} - ${dioResponse.statusMessage}');
      Utils.logWithJson('', dioResponse.data, dioResponse.statusCode, dioResponse.statusMessage);
      var errorMessage = '';
      int? errorCode;
      if (dioResponse.data is Map<String, dynamic>) {
        final data = dioResponse.data as Map<String, dynamic>;
        final errorResponse = Utils.jsonToModel<ApiException>(data, ApiException.fromJson);
        try {
          final errorCodeString = data['errorCode'] as String;
          errorCode = int.tryParse(errorCodeString);
          errorMessage = errorResponse?.error ?? '${ApiErrorMessage.ERROR_HAPPENS} (code: ${dioResponse.statusCode})';
        } catch (_) {
          errorMessage = ApiErrorMessage.APP_PARSE_ERROR;
          errorCode = ApiStatusCode.AppCastError;
        }
      }

      if (dioResponse.statusCode == ApiStatusCode.Unauthorized) {
        _cancelToken.cancel();
        if (hasToken()) {
          LogoutHelper.handleLogout();
        } else {
          throw ApiException(error: errorMessage, statusCode: dioResponse.statusCode, errorCode: errorCode);
        }
      } else if (dioResponse.statusCode == ApiStatusCode.NotHavePermission) {
        throw NoPemissionException();
      } else {
        throw ApiException(
          error: errorMessage,
          statusCode: dioResponse.statusCode,
          errorCode: errorCode,
        );
      }
    } else {
      AppLogger.d('API FAIL 2 - $url - ${error.message}');
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          AppLogger.d('API TIMEOUT');
          throw ApiException(error: ApiErrorMessage.TIMEOUT_ERROR);
        case DioExceptionType.cancel:
          throw ApiException(error: ApiErrorMessage.CANCEL_ERROR);
        case DioExceptionType.unknown:
          AppLogger.d('API ERROR - ${error.message}');
          if (error.error is SocketException) {
            throw ApiException(error: ApiErrorMessage.NETWORK_ERROR);
          }
          throw ApiException(error: ApiErrorMessage.ORTHER_ERROR);
        case DioExceptionType.badCertificate:
          throw ApiException(error: ApiErrorMessage.BAD_CERTIFICATE);
        case DioExceptionType.badResponse:
          throw ApiException(error: ApiErrorMessage.BAD_RESPONSE);

        case DioExceptionType.connectionError:
          throw ApiException(error: ApiErrorMessage.CONNECTION_ERROR);
      }
    }
  }

  static T? handleResponse<T>(T Function() parse) {
    try {
      final result = parse();
      return result;
    } catch (e, s) {
      if (!_cancelToken.isCancelled) {
        AppLogger.d(e.toString());
        AppLogger.d(s.toString());
        throw ApiException(error: ApiErrorMessage.APP_PARSE_ERROR);
      } else {
        return null;
      }
    }
  }
}
