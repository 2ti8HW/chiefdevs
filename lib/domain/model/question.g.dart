// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Question _$QuestionFromJson(Map<String, dynamic> json) => Question(
      json['title'] as String,
      json['subtitle'] as String?,
      json['maxStars'] as int,
      json['canWriteReview'] as bool,
      json['review'] as String?,
      json['stars'] as int?,
    );

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'title': instance.title,
      'subtitle': instance.subtitle,
      'maxStars': instance.maxStars,
      'canWriteReview': instance.canWriteReview,
      'review': instance.review,
      'stars': instance.stars,
    };
