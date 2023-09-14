import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:homework/domain/model/question.dart';
import 'package:homework/extensions/datetime_extension.dart';
import 'package:homework/feature/survey/survey_bloc.dart';
import 'package:homework/question_page.dart';
import 'package:homework/widgets/stars.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          'Daily Questionnaire',
          style: TextStyle(
            color: Colors.black,
            fontSize: 32,
            fontWeight: FontWeight.w600,
            height: 0.62,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size(double.infinity, 62),
          child: Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 32),
            child: Row(
              children: [
                Text(
                  context.read<SurveyBloc>().state.currentDateTime.fullFormat(),
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    height: 1.43,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: BlocBuilder<SurveyBloc, SurveyState>(
        builder: (context, state) {
          if (state.status == SurveyStateStatus.loading ||
              state.status == SurveyStateStatus.initial) {
            return const Center(child: CupertinoActivityIndicator());
          } else if (state.status != SurveyStateStatus.success) {
            return const SizedBox();
          }

          return ListView(
            children: state.questions
                .asMap()
                .entries
                .map((entry) => _ListItem(
                      number: entry.key + 1,
                      question: entry.value,
                      onTap: () => openQuestion(entry.value),
                    ))
                .toList(),
          );
        },
      ),
    );
  }

  Future<void> openQuestion(Question question) async {
    final result = await QuestionPage.open(
      context: context,
      question: question,
    );
    if (result == null) return;

    context.read<SurveyBloc>().add(SurveyUpdateQuestion(
          question,
          result.review,
          result.stars,
        ));
  }
}

class _ListItem extends StatelessWidget {
  static const _borderRadius = BorderRadius.all(Radius.circular(14));
  final int number;
  final Question question;
  final VoidCallback? onTap;

  const _ListItem({
    Key? key,
    required this.number,
    required this.question,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: _borderRadius,
          border: Border.all(color: const Color(0xFFDBDBDB)),
        ),
        child: Material(
          borderRadius: _borderRadius,
          child: InkWell(
            onTap: onTap,
            borderRadius: _borderRadius,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '$number',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            height: 1,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            question.title,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              height: 1,
                            ),
                          ),
                          if (question.subtitle != null) ...[
                            const SizedBox(height: 12),
                            Text(
                              question.subtitle!,
                              style: const TextStyle(
                                color: Color(0xFFC0C0C0),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                height: 1,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Stars(
                    selected: question.stars ?? 0,
                    maxStars: question.maxStars,
                  ),
                  const SizedBox(height: 16),
                  question.canWriteReview
                      ? const WriteReview()
                      : const ReviewDisabled(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class WriteReview extends StatelessWidget {
  const WriteReview({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Text(
          'Write a review',
          style: TextStyle(
            color: Color(0xFF565656),
            fontSize: 16,
            fontWeight: FontWeight.w400,
            height: 1,
          ),
        ),
        const SizedBox(width: 16),
        SvgPicture.asset(
          'assets/icons/more.svg',
        ),
      ],
    );
  }
}

class ReviewDisabled extends StatelessWidget {
  const ReviewDisabled({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          'Review is disabled',
          style: TextStyle(
            color: Color(0xFFC0C0C0),
            fontSize: 16,
            fontWeight: FontWeight.w400,
            height: 1,
          ),
        ),
      ],
    );
  }
}
