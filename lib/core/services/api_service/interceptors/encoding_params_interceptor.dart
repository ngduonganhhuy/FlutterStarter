import 'package:dio/dio.dart';
import 'package:flutter_stater/core/utils/utils.dart';

class EncodingParamsInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.queryParameters.isEmpty) {
      super.onRequest(options, handler);
      return;
    }

    final queryParams = _getQueryParams(options.queryParameters);
    handler.next(
      options.copyWith(
        path: _getNormalizedUrl(options.path, queryParams),
        queryParameters: Map.from({}),
      ),
    );
  }

  String _getNormalizedUrl(String baseUrl, String queryParams) {
    if (Utils.isNullOrEmpty(queryParams)) return baseUrl;
    if (baseUrl.contains('?')) {
      return '$baseUrl&$queryParams';
    } else {
      return '$baseUrl?$queryParams';
    }
  }

  String _getQueryParams(Map<String, dynamic> map) {
    var result = '';
    map.forEach((key, value) {
      result += Utils.isNullOrEmpty(value)
          ? ''
          : value.runtimeType == String
              ? '$key=${Uri.encodeComponent(value.toString())}&'
              : '$key=$value&';
    });
    if (result.isNotEmpty) result = result.substring(0, result.length - 1);
    return result;
  }
}
