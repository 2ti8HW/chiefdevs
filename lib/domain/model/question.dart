import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'question.g.dart';

@JsonSerializable()
class Question extends Equatable {
  final String title;
  final String? subtitle;
  final int maxStars;
  final bool canWriteReview;
  final String? review;
  final int? stars;

  const Question(
    this.title,
    this.subtitle,
    this.maxStars,
    this.canWriteReview,
    this.review,
    this.stars,
  );

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionToJson(this);

  Question copyWith({
    String? title,
    String? subtitle,
    int? maxStars,
    bool? canWriteReview,
    String? review,
    int? stars,
  }) {
    return Question(
      title ?? this.title,
      subtitle ?? this.subtitle,
      maxStars ?? this.maxStars,
      canWriteReview ?? this.canWriteReview,
      review ?? this.review,
      stars ?? this.stars,
    );
  }

  @override
  List<Object?> get props => [
        title,
        subtitle,
        maxStars,
        canWriteReview,
        review,
        stars,
      ];
}
