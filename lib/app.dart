import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homework/build_config.dart';
import 'package:homework/domain/repositories/survey_repository.dart';
import 'package:homework/extensions/material_color_extension.dart';
import 'package:homework/feature/survey/survey_bloc.dart';
import 'package:homework/home_page.dart';

class MyApp extends StatelessWidget {
  final SurveyRepository surveyRepository;

  const MyApp({super.key, required this.surveyRepository});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: surveyRepository,
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: MaterialColorGenerator.from(const Color(
              BuildConfig.accentColor,
            )),
            backgroundColor: Colors.white,
          ),
          useMaterial3: true,
          fontFamily: 'Inter',
        ),
        home: BlocProvider(
          create: (_) => SurveyBloc(surveyRepository: surveyRepository)
            ..add(const SurveyFetch()),
          child: const HomePage(),
        ),
      ),
    );
  }
}
