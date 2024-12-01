import 'package:http/http.dart' as http;

abstract class IHttpClient {
  Future<http.Response> get({required String url});
  Future<http.Response> post({
    required String url,
    required String body,
    required Map<String, String> headers,
  });
}

class HttpClient implements IHttpClient {
  final client = http.Client();

  @override
  Future<http.Response> get({required String url}) async {
    return await client.get(Uri.parse(url));
  }

  @override
  Future<http.Response> post({
    required String url,
    required String body,
    required Map<String, String> headers,
  }) async {
    return await client.post(
      Uri.parse(url),
      body: body,
      headers: headers,
    );
  }
}
