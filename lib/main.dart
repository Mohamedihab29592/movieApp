import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/services/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/local/cache_helper.dart';
import 'core/utilies/strings.dart';
import 'core/utilies/themes.dart';
import 'movie/presentation/controllers/mainScreen/bloc.dart';
import 'movie/presentation/controllers/themeMode/theme_mode_cubit.dart';
import 'movie/presentation/screens/splash_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  ServiceLocator().init();
  await CacheHelper.init();
  final sharedPreferences = await SharedPreferences.getInstance();
  bool? isDarkMode = sharedPreferences.getBool("isDarkMode") ?? false;
  runApp(MyApp(isDarkMode: isDarkMode,));
}

class MyApp extends StatelessWidget {
  final bool isDarkMode;

  const MyApp({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers:[ BlocProvider(create: (context) =>
      ThemeModeCubit()
        ..changeAppMode(fromShared: isDarkMode)),

        BlocProvider(create: (_) => MovieBloc(sl(), sl(), sl(), sl(), sl())),

      ],
        child: BlocBuilder<ThemeModeCubit, ThemeModeState>(
          builder: (context, state) =>
              MaterialApp(
                themeMode: ThemeModeCubit
                    .get(context)
                    .isDarkMode
                    ? ThemeMode.light
                    : ThemeMode.dark,
                darkTheme: AppThemes.darkMode,
                theme: AppThemes.lightMode,
                debugShowCheckedModeBanner: false,
                title: AppStrings.appName,
                home: const SplashScreen(),
              ),
        ),
      );

  }
}


