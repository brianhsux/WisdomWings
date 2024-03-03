import 'package:flutter/material.dart';
import 'package:wisdom_wings/question.dart';

class ReviewPage extends StatelessWidget {
  final List<Question> questionList;
  final List<int> userAnswerResults;

  ReviewPage({required this.questionList, required this.userAnswerResults});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Review Answers'),
      ),
      body: ListView.builder(
        itemCount: questionList.length,
        itemBuilder: (context, index) {
          bool isCorrect =
              userAnswerResults[index] == questionList[index].correctAnswer;
          bool isNoAnswer = userAnswerResults[index] == -1;

          return Card(
            margin: EdgeInsets.all(8.0),
            color: isCorrect ? Colors.green : Colors.red,
            child: ListTile(
              title: Text(
                questionList[index].question,
                style: TextStyle(color: Colors.black, fontSize: 16.0),
              ),
              // subtitle: Text('Your answer: ${userAnswerResultList[index] == questionList[index].correctAnswer ? 'Correct' : 'Wrong'}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(isNoAnswer
                      ? 'No Answer'
                      : 'Your answer: ${questionList[index].options[userAnswerResults[index]]}'),
                  Text(isCorrect
                      ? ''
                      : 'Correct answer is ${questionList[index].options[questionList[index].correctAnswer]}'),
                ],
              ),
              trailing: Icon(
                isCorrect ? Icons.check_circle : Icons.cancel,
                color: isCorrect ? Colors.green : Colors.red,
              ),
              onTap: () {
                // Add any additional actions when the card is tapped
              },
            ),
          );
        },
      ),
    );
  }
}
