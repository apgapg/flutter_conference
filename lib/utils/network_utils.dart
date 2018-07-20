import 'package:http/http.dart' as http;

class NetworkUtils {


  static isReqSuccess({String tag, http.Response response}) {
    if (tag == null)
      tag = "";
    print(tag + response.body.toString());
    if (response.statusCode < 200 || response.statusCode >= 300) {
      print(
          "ResponseErrorCode: " + tag + ": " + response.statusCode.toString());
      return false;
    } else {
      return true;
    }
  }
}
