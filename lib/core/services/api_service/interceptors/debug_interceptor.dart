import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_starter/core/extensions/bool_extension.dart';
import 'package:flutter_starter/core/utils/logger.dart';

class DebugInterceptor extends Interceptor {
  DebugInterceptor({this.printOnSuccess, this.convertFormData = true});
  final bool? printOnSuccess;
  final bool convertFormData;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final curl = _renderCurlRepresentation(err.requestOptions);
    logRequest(curl, err.requestOptions, err.response);

    return handler.next(err); //continue
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    var curl = '';
    if (printOnSuccess != null && printOnSuccess.isTrue) {
      curl = _renderCurlRepresentation(response.requestOptions);
    }
    AppLogger.d('API SUCCESS - ${response.realUri} - ${response.statusCode} - ${response.statusMessage}');
    logRequest(curl, response.requestOptions, response);

    return handler.next(response); //continue
  }

  void logRequest(String curl, RequestOptions requestOptions, Response<dynamic>? response) {
    AppLogger.d(curl);
  }

  String _renderCurlRepresentation(RequestOptions requestOptions) {
    var curl = '';
    try {
      curl = _cURLRepresentation(requestOptions);
    } catch (err) {
      curl = 'unable to create a CURL representation of the requestOptions';
    }
    return curl;
  }

  String _cURLRepresentation(RequestOptions options) {
    final components = <String>['curl -i'];
    if (options.method.toUpperCase() != 'GET') {
      components.add('-X ${options.method}');
    }

    options.headers.forEach((k, v) {
      if (k != 'Cookie') {
        components.add('-H "$k: $v"');
      }
    });

    if (options.data != null) {
      // FormData can't be JSON-serialized, so keep only their fields attributes
      if (options.data is FormData && convertFormData == true) {
        final formData = options.data as FormData;
        options.data = Map.fromEntries(formData.fields);
      }

      final data = json.encode(options.data).replaceAll('"', r'\"');
      components.add('-d "$data"');
    }

    components.add('"${options.uri}"');

    return components.join(' \\\n\t');
  }
}
