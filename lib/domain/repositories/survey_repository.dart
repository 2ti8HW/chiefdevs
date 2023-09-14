import 'package:homework/domain/model/question.dart';

abstract class SurveyRepository {
  Future<List<Question>> fetchQuestions();
}
