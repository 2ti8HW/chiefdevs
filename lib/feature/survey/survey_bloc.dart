import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:homework/domain/model/question.dart';
import 'package:homework/domain/repositories/survey_repository.dart';

part 'survey_event.dart';
part 'survey_state.dart';

class SurveyBloc extends Bloc<SurveyEvent, SurveyState> {
  final SurveyRepository _surveyRepository;

  SurveyBloc({
    required SurveyRepository surveyRepository,
  })  : _surveyRepository = surveyRepository,
        super(SurveyState(currentDateTime: DateTime.now())) {
    on<SurveyFetch>(_onSurveyFetch);
    on<SurveyUpdateQuestion>(_onSurveyUpdateQuestion);
  }

  Future<void> _onSurveyFetch(
    SurveyFetch event,
    Emitter<SurveyState> emit,
  ) async {
    emit(state.copyWith(status: SurveyStateStatus.loading));

    try {
      final result = await _surveyRepository.fetchQuestions();
      emit(
        state.copyWith(status: SurveyStateStatus.success, questions: result),
      );
    } catch (_) {
      emit(state.copyWith(status: SurveyStateStatus.failure));
    }
  }

  Future<void> _onSurveyUpdateQuestion(
    SurveyUpdateQuestion event,
    Emitter<SurveyState> emit,
  ) async {
    final questions = [...state.questions];
    final index = questions.indexOf(event.question);

    questions[index] = questions[index].copyWith(
      review: event.review,
      stars: event.stars,
    );
    emit(
      state.copyWith(status: SurveyStateStatus.success, questions: questions),
    );
  }
}
