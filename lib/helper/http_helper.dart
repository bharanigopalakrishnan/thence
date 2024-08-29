import 'package:http/http.dart' as http;

class HttpHelper extends http.BaseClient {
  static HttpHelper instance = HttpHelper._();

  final http.Client _httpClient = http.Client();

  HttpHelper._();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    request.headers.addAll({
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    return _httpClient.send(request);
  }
}
