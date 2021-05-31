import 'package:dio/dio.dart';
import 'package:test_app/models/model_test_structure.dart';

class WebService {
  var dio = Dio();

  Future<List<TestStructure>> getTests() async {
    String url = 'https://opentdb.com/api.php?amount=10&type=multiple';

    final response = await dio.get(url);

    if (response.statusCode == 200) {
      final result = response.data;
      Iterable list = result['results'];
      return list.map((test) => TestStructure.fromJson(test)).toList();
    } else {
      throw Exception("Failed to get tests");
    }
  }
}