import 'dart:convert';
import 'package:http/http.dart' as http;

var baseURL = "https://opentdb.com/api.php?amount=20";

getQuiz() async {
  var res = await http.get(Uri.parse(baseURL));
  if (res.statusCode == 200) {
    var data = jsonDecode(res.body.toString());
    return data;
  }
}
