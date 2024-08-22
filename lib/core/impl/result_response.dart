class ResultResponse<TData, TError> {
  ResultResponse({
    required this.data,
    required this.error,
    required this.status,
    this.debug,
    this.message,
  });

  factory ResultResponse.loading() {
    return ResultResponse(
      data: null,
      error: null,
      status: ResultStatus.loading,
    );
  }

  factory ResultResponse.error(TError error) {
    return ResultResponse(
      data: null,
      error: error,
      status: ResultStatus.failed,
    );
  }

  factory ResultResponse.success(TData data) {
    return ResultResponse(
      data: data,
      error: null,
      status: ResultStatus.success,
    );
  }

  final TData? data;
  final String? message;
  final TError? error;
  final Map<String, dynamic>? debug;
  final ResultStatus status;
}

enum ResultStatus { success, failed, loading, tokenExpired }

extension ResultResponseExt on ResultResponse<dynamic, dynamic> {
  bool get isTrue => status == ResultStatus.success;
}
