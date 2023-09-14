part of 'question_view_bloc.dart';

sealed class QuestionViewEvent extends Equatable {
  const QuestionViewEvent();

  @override
  List<Object> get props => [];
}

class ReviewChanged extends QuestionViewEvent {
  const ReviewChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class StarsChanged extends QuestionViewEvent {
  const StarsChanged(this.stars);

  final int stars;

  @override
  List<Object> get props => [stars];
}

class QuestionSubmitted extends QuestionViewEvent {
  const QuestionSubmitted();
}
