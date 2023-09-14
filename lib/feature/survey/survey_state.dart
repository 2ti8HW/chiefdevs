part of 'survey_bloc.dart';

enum SurveyStateStatus { initial, loading, success, failure }

class SurveyState extends Equatable {
  final DateTime currentDateTime;
  final SurveyStateStatus status;
  final List<Question> questions;

  const SurveyState({
    required this.currentDateTime,
    this.status = SurveyStateStatus.initial,
    this.questions = const [],
  });

  SurveyState copyWith({
    SurveyStateStatus? status,
    List<Question>? questions,
  }) {
    return SurveyState(
      currentDateTime: currentDateTime,
      status: status ?? this.status,
      questions: questions ?? this.questions,
    );
  }

  @override
  List<Object> get props => [status, questions];
}
