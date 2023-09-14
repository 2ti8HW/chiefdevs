import 'package:homework/domain/model/question.dart';

abstract class SurveyApiClient {
  const SurveyApiClient();

  Future<List<Question>> fetchQuestions();
}
