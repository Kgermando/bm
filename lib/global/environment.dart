import 'package:http/http.dart' as http;

class Environment {
  static String serverUrl = "http://192.168.43.230:3000/api";

  var loginUrl = Uri.parse("$serverUrl/auth/login");
  var registerUrl = Uri.parse("$serverUrl/auth/register");
  var getuserUrl = Uri.parse("$serverUrl/auth/user");
}
