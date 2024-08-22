class BaseModel<T> {
  BaseModel({this.data, this.status, this.message});

  factory BaseModel.fromJson(Map<dynamic, dynamic> json) => BaseModel(
        data: json['data'] as T?,
        status: json['status'] as int?,
        message: json['message'] as String?,
      );

  T? data;
  int? status;
  String? message;

  Map<String, dynamic> toJson() => {
        'data': data,
        'status': status,
        'message': message,
      };
}
