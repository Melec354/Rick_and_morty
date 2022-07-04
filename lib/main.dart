import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_update1/common/app_colors.dart';
import 'package:rick_and_morty_update1/feature/presentation/bloc/person_list_cubit/person_list_cubit.dart';
import 'package:rick_and_morty_update1/feature/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:rick_and_morty_update1/feature/presentation/pages/person_screen.dart';

import 'locator_servies.dart' as di;
import 'locator_servies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<PersonListCubit>(
              create: (context) => sl<PersonListCubit>()..loadPerson()),
          BlocProvider<PersonSearchBloc>(
              create: (context) => sl<PersonSearchBloc>())
        ],
        child: MaterialApp(
          theme: ThemeData.dark().copyWith(
            backgroundColor: AppColors.mainBackground,
            scaffoldBackgroundColor: AppColors.mainBackground,
          ),
          home: HomePage(),
        ));
  }
}
