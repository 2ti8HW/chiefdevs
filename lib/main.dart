import 'package:flutter/material.dart';
import 'package:homework/app.dart';
import 'package:homework/data/assets_survey_api_client.dart';
import 'package:homework/data/survey_repository_impl.dart';

void main() {
  final surveyApiClient = AssetsSurveyApiClient();
  final surveyRepository = SurveyRepositoryImpl(surveyApiClient);

  runApp(MyApp(surveyRepository: surveyRepository));
}
