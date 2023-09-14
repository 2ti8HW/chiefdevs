import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:homework/domain/model/question.dart';
import 'package:homework/feature/question_view/question_view_bloc.dart';
import 'package:homework/widgets/stars.dart';

class QuestionResult {
  final String? review;
  final int stars;

  const QuestionResult({
    this.review,
    required this.stars,
  });
}

class QuestionPage extends StatefulWidget {
  final Question question;

  const QuestionPage({super.key, required this.question});

  static Future<QuestionResult?> open({
    required BuildContext context,
    required Question question,
  }) {
    return showModalBottomSheet<QuestionResult>(
      context: context,
      backgroundColor: Colors.white,
      builder: (context) => BlocProvider(
        create: (_) => QuestionViewBloc(question),
        child: QuestionPage(question: question),
      ),
    );
  }

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _Header(),
            const SizedBox(height: 16),
            Text(
              widget.question.title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 32,
                fontWeight: FontWeight.w600,
                height: 1,
              ),
            ),
            if (widget.question.subtitle != null) ...[
              const SizedBox(height: 16),
              Text(
                widget.question.subtitle!,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  height: 1.43,
                ),
              ),
            ],
            const SizedBox(height: 16),
            _Stars(),
            if (widget.question.canWriteReview) ...[
              const SizedBox(height: 16),
              _Review()
            ],
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _onConfirmPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 66,
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Confirm',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    height: 1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onConfirmPressed() {
    final state = context.read<QuestionViewBloc>().state;
    Navigator.of(context).pop(
      QuestionResult(stars: state.stars, review: state.review),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        SizedBox(
          height: 16,
          width: 16,
          child: IconButton(
            icon: SvgPicture.asset(
              'assets/icons/close.svg',
              width: 16,
              height: 16,
            ),
            padding: EdgeInsets.zero,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ],
    );
  }
}

class _Stars extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<QuestionViewBloc>().state;
    return Stars(
      selected: state.stars,
      maxStars: state.question.maxStars,
      onTap: (value) =>
          context.read<QuestionViewBloc>().add(StarsChanged(value)),
    );
  }
}

class _Review extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<QuestionViewBloc>().state;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Write a review',
          style: TextStyle(
            color: Color(0xFFC0C0C0),
            fontSize: 16,
            fontWeight: FontWeight.w500,
            height: 1,
          ),
        ),
        const SizedBox(height: 12),
        TextFormField(
          initialValue: state.review,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w400,
            height: 1,
          ),
          maxLines: 6,
          minLines: 6,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 0.25,
                color: Color(0xFFDBDBDB),
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 0.25,
                color: Color(0xffAAAAAA),
              ),
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          onChanged: (value) {
            context.read<QuestionViewBloc>().add(ReviewChanged(value));
          },
        ),
      ],
    );
  }
}
