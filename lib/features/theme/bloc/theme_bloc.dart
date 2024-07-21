// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_practical_test/core/enums/app_theme_enum.dart';
import 'package:flutter_practical_test/core/theme/app_theme.dart';
import 'package:flutter_practical_test/features/theme/bloc/theme_event.dart';
import 'package:flutter_practical_test/features/theme/bloc/theme_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  static const String prefKey = 'isDarkTheme';

  ThemeBloc()
      : super(
            ThemeInitial(themeData: AppTheme.getThemeFromKey(ThemeKey.light))) {
    on<ToggleThemeEvent>(_mapEventToState);
    _loadTheme();
  }

  void _mapEventToState(
      ToggleThemeEvent event, Emitter<ThemeState> emit) async {
    if (state is ThemeInitial &&
        (state as ThemeInitial).themeData ==
            AppTheme.getThemeFromKey(ThemeKey.light)) {
      emit(ThemeChanged(themeData: AppTheme.getThemeFromKey(ThemeKey.dark)));
      _saveThemePreference(true);
    } else if (state is ThemeChanged &&
        (state as ThemeChanged).themeData ==
            AppTheme.getThemeFromKey(ThemeKey.dark)) {
      emit(ThemeChanged(themeData: AppTheme.getThemeFromKey(ThemeKey.light)));
      _saveThemePreference(false);
    } else {
      emit(ThemeChanged(themeData: AppTheme.getThemeFromKey(ThemeKey.dark)));
      _saveThemePreference(true);
    }
  }

  void _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkTheme = prefs.getBool(prefKey) ?? false;
    if (isDarkTheme) {
      emit(ThemeInitial(themeData: AppTheme.getThemeFromKey(ThemeKey.dark)));
    } else {
      emit(ThemeInitial(themeData: AppTheme.getThemeFromKey(ThemeKey.light)));
    }
  }

  void _saveThemePreference(bool isDarkTheme) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(prefKey, isDarkTheme);
  }
}
