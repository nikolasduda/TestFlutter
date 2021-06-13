import 'package:dio/dio.dart';
import 'package:test_app/models/model_question.dart';
import "package:html_unescape/html_unescape.dart";

class WebService {
  var dio = Dio();

  Future<List<Question>> getQuestions() async {
    String url = 'https://opentdb.com/api.php?amount=10&type=multiple';

    final response = await dio.get(url);

    if (response.statusCode == 200) {
      var unescape = HtmlUnescape();
      final result = response.data;
      Iterable list = result['results'];
      return list.map((test) => Question.fromJson(test, unescape)).toList();
    } else {
      throw Exception("Failed to get questions");
    }
  }
}