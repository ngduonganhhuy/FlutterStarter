class ApiException implements Exception {
  ApiException({
    this.error,
    this.statusCode,
    this.errorCode,
  });

  factory ApiException.fromJson(Map<String, dynamic> map) {
    return ApiException(
      error: map['error'] != null ? map['error'] as String : null,
      statusCode: map['statusCode'] != null ? map['statusCode'] as int : null,
      errorCode: map['errorCode'] != null ? map['errorCode'] as int : null,
    );
  }
  final String? error;
  final int? statusCode;
  final int? errorCode;

  @override
  String toString() {
    if (error == null) return 'Exception';
    return '$error';
  }
}

class KeyException {
  static const DUPLICATED = 'duplicated_record';
}

class ApiErrorMessage {
  static const ERROR_HAPPENS = 'Có lỗi xảy ra';
  static const NETWORK_ERROR = 'Có lỗi xảy ra (code: no connection)';
  static const TIMEOUT_ERROR = 'Có lỗi xảy ra (code: timeout)';
  static const UNKNOWN_ERROR = 'Có lỗi xảy ra (code: unknown)';
  static const CANCEL_ERROR = 'Có lỗi xảy ra (code: cancel)';
  static const ORTHER_ERROR = 'Có lỗi xảy ra (code: orther)';
  static const APP_API_ERROR = 'Có lỗi xảy ra (code: 101)';
  static const APP_PARSE_ERROR = 'Có lỗi xảy ra (code: 102)';
  static const APP_BLOC_ERROR = 'Có lỗi xảy ra (code: 103)';
  static const APP_UNKNOWN_ERROR = 'Có lỗi xảy ra (code: 104)';
  static const APP_EXCEPTION_ERROR = 'Có lỗi xảy ra (code: 105)';
  static const APP_OTHER_ERROR = 'Có lỗi xảy ra (code: 106)';
  static const DOWNLOAD_CANT_GET_FILENAME_ERROR = 'Có lỗi xảy ra (code: 107)';
  static const NO_PERMISSION = 'Có lỗi xảy ra (code: 108)';
  static const BAD_CERTIFICATE = 'Có lỗi xảy ra (code: 109)';
  static const BAD_RESPONSE = 'Có lỗi xảy ra (code: 110)';
  static const CONNECTION_ERROR = 'Có lỗi xảy ra (code: 111)';
  static const NULL_RESPONSE = 'Có lỗi xảy ra (code: 112)';
  static const UNAUTHORIZED = 'Có lỗi xảy ra (code: 113)';
  static const NOT_FOUND = 'Có lỗi xảy ra (code: 114)';

  static const ERROR_TRY_LATER = 'Có lỗi xảy ra. Vui lòng thử lại sau!';
}

class ApiStatusCode {
  static const Success = 200;
  static const BadRequest = 400;
  static const Unauthorized = 401;
  static const NotFound = 404;
  static const NotHavePermission = 403;
  static const InternalServerError = 500;
  static const AppCastError = 9999;
}

class NotFoundException extends ApiException {
  NotFoundException() : super(error: ApiErrorMessage.NOT_FOUND, statusCode: 404);
}

class UnAuthorizeException extends ApiException {
  UnAuthorizeException() : super(error: ApiErrorMessage.UNAUTHORIZED, statusCode: 401);
}

class NoPemissionException extends ApiException {
  NoPemissionException() : super(error: ApiErrorMessage.NO_PERMISSION);
}

class NullException extends ApiException {
  NullException() : super(error: ApiErrorMessage.NULL_RESPONSE);
}

class ServerException extends ApiException {
  ServerException() : super(error: ApiErrorMessage.APP_API_ERROR);
}
