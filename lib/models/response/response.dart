class Response<T> {
  T? data;
  String? error;
  Response({this.data, this.error});

  factory Response.fromJson(
      Map<String, dynamic> json, T Function(dynamic) fromJsonData) {
    return Response(
        data: json["data"] != null ? fromJsonData(json["data"]) : null,
        error: json["error"]);
  }
}
