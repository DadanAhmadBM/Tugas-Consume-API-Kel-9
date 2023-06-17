import '../utils/endpoint.dart';
import '../utils/request_helper.dart';
import 'package:http/http.dart' as http;

class TodoServices {
  Future<http.Response> fetch() async {
    String endPoint = EndPoint.todo;
    Uri url = Uri.parse(endPoint);
    return await http.get(
      url,
      headers: RequestHelper.basicHeader(),
    );
  }
}