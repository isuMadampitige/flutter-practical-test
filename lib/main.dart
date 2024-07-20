import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_practical_test/features/book/presentation/bloc/book_bloc.dart';
import 'package:flutter_practical_test/features/favorites/presentation/bloc/favorite_bloc.dart';

import 'core/routes/app_routs.dart';
import 'features/book_details/presentaion/bloc/book_details_bloc.dart';
import 'features/home/presentation/bloc/home_bloc.dart';
import 'features/home/presentation/pages/home_page.dart';
import 'features/theme/bloc/theme_bloc.dart';
import 'features/theme/bloc/theme_state.dart';
import 'injection_container.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeBloc(),
        ),
        BlocProvider(
          create: (_) => locator<HomeBloc>(),
        ),
        BlocProvider(
          create: (_) => locator<BookBloc>(),
        ),
        BlocProvider(
          create: (_) => locator<FavoriteBloc>(),
        ),
        BlocProvider(
          create: (_) => locator<BookDetaisBloc>(),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Practical Test',
              theme: themeState is ThemeInitial
                  ? themeState.themeData
                  : (themeState as ThemeChanged).themeData,
              home: const HomePage(),
              onGenerateRoute: AppRoutes.generateRoute);
        },
      ),
    );
  }
}
