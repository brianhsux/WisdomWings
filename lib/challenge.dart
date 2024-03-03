import 'package:flutter/material.dart';
import 'package:wisdom_wings/main.dart';
import 'package:wisdom_wings/question.dart';
import 'package:wisdom_wings/review_page.dart';

class ChallengePage extends StatefulWidget {
  final String categoryName;
  final Map<String, dynamic> jsonData;

  ChallengePage({required this.categoryName, required this.jsonData});

  @override
  _ChallengePageState createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage> {
  int currentQuestionIndex = 0;
  int experience = 0;

  List<Question> questionList = [];
  List<int> userAnswerResultList = [];

  List<Map<String, dynamic>> spaceQuestions = [];
  bool isAnswerSelected = false;

  int? selectedAnswer;

  @override
  void initState() {
    super.initState();
    // _generateQuestions();

    // Usage example
    // String categoryName = "宇宙和天文学";
    spaceQuestions =
        getQuestionsByCategoryName(widget.categoryName, widget.jsonData);

    _generateQuestions(spaceQuestions);
  }

  // Define a function to get questions by category name
  List<Map<String, dynamic>> getQuestionsByCategoryName(
      String categoryName, Map<String, dynamic> jsonData) {
    List<dynamic> categories = jsonData['categories'];

    for (var category in categories) {
      if (category['name'] == categoryName) {
        return List<Map<String, dynamic>>.from(category['questions']);
      }
    }

    // Return an empty list if category is not found
    return [];
  }

  void _generateQuestions(List<Map<String, dynamic>> spaceQuestions) {
    spaceQuestions.forEach((questionData) {
      String questionText = questionData['question'];
      List<String> options = List<String>.from(questionData['options']);
      int correctAnswer = questionData['correctAnswer'];

      Question question = Question(
        question: questionText,
        options: options,
        correctAnswer: correctAnswer,
      );

      questionList.add(question);
      userAnswerResultList.add(-1);
    });

    // Print the generated question list
    print('Generated Question List:');
    questionList.forEach((question) {
      print('Question: ${question.question}');
      print('Options: ${question.options}');
      print('Correct Answer: ${question.correctAnswer}');
      print('-----------------------');
    });
  }

  List<bool> answerStatus = List.filled(4, false);
  bool showAnswerStatus = false;

  void _handleAnswerSelection(int choiceIndex) {
    if (!showAnswerStatus) {
      setState(() {
        showAnswerStatus = true;
        answerStatus[choiceIndex] = true;
        userAnswerResultList[currentQuestionIndex] = choiceIndex;

        if (choiceIndex == questionList[currentQuestionIndex].correctAnswer) {
          // Correct answer selected
          experience += 1;
        }

        isAnswerSelected = true; // Set to true when user selects an answer
      });
    }
  }

  Widget _buildChoiceButton(int choiceIndex) {
    return ElevatedButton(
      onPressed: () {
        _handleAnswerSelection(choiceIndex);
      },
      style: ElevatedButton.styleFrom(
        primary: showAnswerStatus
            ? (answerStatus[choiceIndex]
                ? (choiceIndex ==
                        questionList[currentQuestionIndex].correctAnswer
                    ? Colors.green
                    : Colors.red)
                : null)
            : null,
        onPrimary: Colors.white,
      ),
      child: Text('${questionList[currentQuestionIndex].options[choiceIndex]}'),
    );
  }

  void _resetAnswerStatus() {
    setState(() {
      showAnswerStatus = false;
      answerStatus = List.filled(4, false);
      isAnswerSelected = false;
    });
  }

  Widget _buildCompleteButtonText() {
    if (currentQuestionIndex == questionList.length - 1) {
      return Text('Challenge Complete');
    } else {
      return Text('Next Question');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Challenge - Category ${widget.categoryName}'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              questionList[currentQuestionIndex].question,
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: List.generate(
                4,
                (choiceIndex) => _buildChoiceButton(choiceIndex),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isAnswerSelected
                      ? () {
                          // Move to the next question or show the results if all questions are answered
                          if (currentQuestionIndex < questionList.length - 1) {
                            _resetAnswerStatus();
                            setState(() {
                              currentQuestionIndex += 1;
                              selectedAnswer =
                                  null; // Reset selected answer for the next question
                            });
                          } else {
                            // Display a dialog with the total experience when all questions are answered
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Challenge Completed'),
                                  content:
                                      Text('Total Experience: $experience'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        Navigator.of(context)
                                            .pop(); // Close the challenge page

                                        // Navigate to the ReviewPage to review answers
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ReviewPage(
                                              questionList: questionList,
                                              userAnswerResults:
                                                  userAnswerResultList,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Text('View Results'),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        }
                      : null, // Disable button if answer is not selected
                  child: _buildCompleteButtonText(),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
