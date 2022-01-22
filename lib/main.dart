import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'src/calculator_mode_views/calculator_mode.dart';
import 'src/calculator_mode_views/calculator_mode_view_rebuilder.dart';
import 'src/theme/app_theme.dart';
import 'src/theme/theme_controller.dart';

final expressionProvider =
    StateProvider((ref) => ''); //stores the current expression
final historyProvider =
    StateProvider((ref) => ''); //stores the last evaluated expression
final hapticFeedbackProvider =
    StateProvider((ref) => true); //stores if haptic feedback is enabled
final radianProvider = StateProvider(
    (ref) => true); //stores if expressions are to be evaluated in radians
final calculatorDisplayDirectionProvider = StateProvider((ref) =>
    true); //stores if the expression has been calculated and has to be displayed from the beginning

ThemeController themeController = ThemeController(); //controls the app theme
CalculatorMode calculatorMode =
    CalculatorMode(); //controls the calculator mode (simple or advanced)

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const ProviderScope(child: MyApp()));
  });
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  int themeMode = 0; //0 is system theme, 1 is light theme, 2 is dark theme

  Future<void> checkState() async {
    await SharedPreferences.getInstance().then((value) {
      ref.read(hapticFeedbackProvider.state).state =
          value.getBool('haptic_feedback') ?? true;
      themeMode = value.getInt('theme_mode') ?? 0;
      if (themeMode != 0) {
        themeController
            .changeTheme(themeMode == 1 ? ThemeMode.light : ThemeMode.dark);
      }
      ref.read(radianProvider.state).state = value.getBool('is_radian') ?? true;
    });
  }

  @override
  void initState() {
    super.initState();
    themeController.addListener(() {
      setState(() {});
    });
    checkState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: themeController.currentTheme,
        home: const CalculatorModeViewRebuilder());
  }
}
