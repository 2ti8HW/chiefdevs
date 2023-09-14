import 'package:homework/domain/model/question.dart';
import 'package:homework/domain/repositories/survey_repository.dart';
import 'package:homework/domain/survey_api_client.dart';

class SurveyRepositoryImpl extends SurveyRepository {
  final SurveyApiClient _surveyApiClient;

  SurveyRepositoryImpl(this._surveyApiClient);

  @override
  Future<List<Question>> fetchQuestions() => _surveyApiClient.fetchQuestions();
}
