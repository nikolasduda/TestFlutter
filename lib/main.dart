import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async {
  Parser parser = new Parser();
  await parser.parse();//выполниться раньше чем запуститься приложение
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Test',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Parser parser = new Parser();
  String mainNote = 'Do you want to take the test?';
  String buttonText = 'Yes I do';
  int result;

  setNote() {
    if (result != null) {
      String temp =  "Your result is: $result out of 10.";
      if (result >= 6) {
        return temp + "Test passed.";
      } else {
        return temp + "Test failed.";
      }
    }
    return mainNote;
  }

  setButtonText() {
    if (result != null) {
      return "OK";
    }
    return buttonText;
  }

  setMainState() {
    setState(() {
      result = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("TestApp")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 200),
                  ),
                  Flexible(
                    child: Text(
                      setNote(),
                      style: TextStyle(fontWeight: FontWeight.bold,
                        fontSize: 40,
                        fontFamily: 'Roboto',),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () async {
                      if (result != null) {
                        setMainState();
                      } else {
                        result = await Navigator.push(context, MaterialPageRoute(builder: (context) => TestCreatorWidget()));
                        setState(() {
                          parser.clear();
                          parser.parse();
                        });
                      }
                      },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.indigo,
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                        textStyle: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto',
                      )
                    ),
                    child: Text(setButtonText())),
                Padding(padding: EdgeInsets.only(bottom: 150)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TestCreatorWidget extends StatefulWidget {
  const TestCreatorWidget({Key key}) : super(key: key);

  @override
  _TestCreatorState createState() => _TestCreatorState();
}

class _TestCreatorState extends State<TestCreatorWidget> {
  String buttonText = "Next";
  int rightAnswers = 0;
  int answerCount = 0;
  int selectedRadio;
  TestManager testManager = new TestManager();

  void nextQuestion() {
    if (selectedRadio != -1) {
      isRightAnswer();
      selectedRadio = -1;
      if (answerCount == 8) {
        buttonText = "Find out the result";
      }
      setState(() {
        answerCount++;
      });
    }
  }

  void isRightAnswer() {
    if (testManager.getAnswers(answerCount).elementAt(selectedRadio) == testManager.getRightAnswer(answerCount)) {
      rightAnswers++;
    }
  }

  @override
  void initState() {
    super.initState();
    selectedRadio = -1;
  }

  setSelectRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("TestApp")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 200),
                ),
                Flexible(
                  child: Text(
                    testManager.getQuestion(answerCount),
                    style: TextStyle(fontWeight: FontWeight.bold,
                      fontSize: 30,
                      fontFamily: 'Roboto',),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
            Row(
              children: [ButtonBar(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row (
                          children: [
                            Radio(
                              value: 0,
                              groupValue: selectedRadio,
                              onChanged: (val) {
                                setSelectRadio(val);
                              },
                            ),
                            Text(testManager.getAnswers(answerCount).elementAt(0))
                          ]
                      ),
                      Row (
                          children: [
                            Radio(
                              value: 1,
                              groupValue: selectedRadio,
                              onChanged: (val) {
                                setSelectRadio(val);
                              },
                            ),
                            Text(testManager.getAnswers(answerCount).elementAt(1)),
                          ]
                      ),
                      Row (
                          children: [
                            Radio(
                              value: 2,
                              groupValue: selectedRadio,
                              onChanged: (val) {
                                setSelectRadio(val);
                              },
                            ),
                            Text(testManager.getAnswers(answerCount).elementAt(2)),
                          ]
                      ),
                      Row (
                          children: [
                            Radio(
                              value: 3,
                              groupValue: selectedRadio,
                              onChanged: (val) {
                                setSelectRadio(val);
                              },
                            ),
                            Text(testManager.getAnswers(answerCount).elementAt(3)),
                          ]
                      )
                    ],),
                ],),]
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      if (answerCount == 9) {
                        isRightAnswer();
                        Navigator.of(context).pop(rightAnswers);
                      } else {
                        nextQuestion();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.indigo,
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                        textStyle: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto',
                        )
                    ),
                    child: Text(buttonText)),
                Padding(padding: EdgeInsets.only(bottom: 150)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class NetworkHelper {
  NetworkHelper({this.url});

  final String url;

  Future getData() async {
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      String data = response.body;

      return json.decode(data);
    }
      print("Something went wrong. Status code: " + response.statusCode.toString());
  }
}

class TestManager {
  
  String getQuestion(int i) {
    return Parser.question[i];
  }

  String getRightAnswer(int i) {
    return Parser.correctAnswer[i];
  }

  Set getAnswers(int i) {
    Set<String> answers = new Set<String>();
    answers.add(Parser.correctAnswer[i]);
    for(int j = 0; j < Parser.incorrectAnswers[i].length; j++) {
      answers.add(Parser.incorrectAnswers[i][j]);
    }

    return answers;
  }
}

class Parser {
  NetworkHelper networkHelper = new NetworkHelper(url : Constants.url);
  static List<String> question = new List<String>();
  static List<String> correctAnswer = new List<String>();
  static List<List<String>> incorrectAnswers = new List<List<String>>();

  String deleteSymbols(String str) {
    str = str.replaceAll("&#039;", "\'");
    str = str.replaceAll("&quot;", "\"");
    
    return str;
  }

  void clear() {
    question.clear();
    correctAnswer.clear();
    incorrectAnswers.clear();
  }

  Future parse() async {
    var data = await networkHelper.getData();

    for(int i = 0; i < data['results'].length; i++) {
      question.add(deleteSymbols(data['results'][i]['question']));
      correctAnswer.add(deleteSymbols(data['results'][i]['correct_answer']));
      List<String> temp = new List<String>();
      for (int j = 0; j < data['results'][i]['incorrect_answers'].length; j++) {
        temp.add(deleteSymbols(data['results'][i]['incorrect_answers'][j]));
      }
      incorrectAnswers.add(temp);
    }
    print("Parsing is over");
  }
}

class Constants {
  static String url = 'https://opentdb.com/api.php?amount=10&type=multiple';
}