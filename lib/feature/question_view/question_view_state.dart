part of 'question_view_bloc.dart';

class QuestionViewState extends Equatable {
  final Question question;
  final String review;
  final int stars;

  const QuestionViewState({
    required this.question,
    this.review = '',
    this.stars = 0,
  });

  QuestionViewState copyWith({
    Question? question,
    String? review,
    int? stars,
  }) {
    return QuestionViewState(
      question: question ?? this.question,
      review: review ?? this.review,
      stars: stars ?? this.stars,
    );
  }

  @override
  List<Object> get props => [question, review, stars];
}
