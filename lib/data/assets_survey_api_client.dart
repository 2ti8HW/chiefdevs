import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:homework/domain/model/question.dart';
import 'package:homework/domain/survey_api_client.dart';

class AssetsSurveyApiClient extends SurveyApiClient {
  @override
  Future<List<Question>> fetchQuestions() async {
    final data = await _loadDatas();
    return (json.decode(data) as List<dynamic>)
        .map((e) => Question.fromJson(e))
        .toList();
  }

  Future<String> _loadDatas() async {
    return await rootBundle.loadString('assets/questions.json');
  }
}
