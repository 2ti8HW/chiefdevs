part of 'survey_bloc.dart';

sealed class SurveyEvent extends Equatable {
  const SurveyEvent();

  @override
  List<Object?> get props => [];
}

final class SurveyFetch extends SurveyEvent {
  const SurveyFetch();
}

final class SurveyUpdateQuestion extends SurveyEvent {
  final Question question;
  final String? review;
  final int stars;

  const SurveyUpdateQuestion(this.question, this.review, this.stars);

  @override
  List<Object?> get props => [question, review, stars];
}
