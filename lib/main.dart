import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app/viewmodels/viewmodel_question_structure_list.dart';
import 'package:test_app/views/main.dart';
import 'package:test_app/views/result_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => MainPage(),
          '/result_page': (context) => ResultPage(),
        });
  }
}
