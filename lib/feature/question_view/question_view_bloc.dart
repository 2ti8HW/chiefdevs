import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:homework/domain/model/question.dart';

part 'question_view_event.dart';
part 'question_view_state.dart';

class QuestionViewBloc extends Bloc<QuestionViewEvent, QuestionViewState> {
  final Question question;

  QuestionViewBloc(this.question)
      : super(QuestionViewState(question: question)) {
    on<ReviewChanged>(_onReviewChanged);
    on<StarsChanged>(_onStarsChanged);
  }

  void _onReviewChanged(
    ReviewChanged event,
    Emitter<QuestionViewState> emit,
  ) {
    emit(state.copyWith(review: event.value));
  }

  void _onStarsChanged(
    StarsChanged event,
    Emitter<QuestionViewState> emit,
  ) {
    emit(state.copyWith(stars: event.stars));
  }
}
