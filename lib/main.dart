import 'package:bbb/firebase_options.dart';
import 'package:bbb/pages/MonthlyView/day_completed_page.dart';
import 'package:bbb/pages/MonthlyView/day_overview_page.dart';
import 'package:bbb/pages/MonthlyView/today_page.dart';
import 'package:bbb/pages/Tools/nutrition_calculator_page.dart';
import 'package:bbb/pages/Tools/recalculate_page.dart';
import 'package:bbb/pages/calendar_page.dart';
import 'package:bbb/pages/email_verification_page.dart';
import 'package:bbb/pages/Tools/exercise_library_page.dart';
import 'package:bbb/pages/Tools/graph_and_reports_page.dart';
import 'package:bbb/pages/exercise_page.dart';
import 'package:bbb/pages/main_page.dart';
import 'package:bbb/pages/login_page.dart';
import 'package:bbb/pages/on_boarding_page.dart';
import 'package:bbb/pages/register_page.dart';
import 'package:bbb/pages/reset_password_page.dart';
import 'package:bbb/pages/streak_page.dart';
import 'package:bbb/pages/ProfileAndSettings/myprofile_page.dart';

import 'package:bbb/providers/data_provider.dart';
import 'package:bbb/providers/user_data_provider.dart';
import 'package:bbb/values/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:provider/provider.dart';
import 'package:app_links/app_links.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final dataProvider = ChangeNotifierProvider<DataProvider>(
    create: (context) => DataProvider(),
  );

  final userDataProvider = ChangeNotifierProvider<UserDataProvider>(
    create: (context) => UserDataProvider(),
  );

  late AppLinks _appLinks;

  @override
  void initState() {
    super.initState();
    _initDeepLinkListener();
  }

  Future<void> _initDeepLinkListener() async {
    // Initialize AppLinks and handle the deep link in the callback
    _appLinks = AppLinks(
      onAppLink: (Uri uri, String? stringUri) {
        _handleDeepLink(uri.toString());
      },
    );
  }

  void _handleDeepLink(String? deepLink) {
    debugPrint('##########################1: $deepLink######################');
    if (deepLink != null) {
      // Parse the deep link and navigate to the appropriate page
      Uri uri = Uri.parse(deepLink);
      debugPrint('##########################2: $deepLink######################');
      // Check if the scheme and host are correct
      if (uri.scheme == 'https' && uri.host == 'bbbdev1.wpenginepowered.com') {
        // Example: Check the path
        debugPrint('##########################3: $deepLink######################');
        Navigator.of(context).pushNamed(AppRoutes.mainScreen);
      } else {
        // Handle unsupported schemes or hosts if necessary
        debugPrint('Unsupported deep link: $deepLink');
      }
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [dataProvider, userDataProvider],
      child: MaterialApp(
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        home: const OnBoardingPage(),
        routes: {
          AppRoutes.onBoardingScreen: (context) => const OnBoardingPage(),
          AppRoutes.mainScreen: (context) => const MainPage(),
          AppRoutes.loginScreen: (context) => const LoginPage(),
          AppRoutes.registerScreen: (context) => const RegisterPage(),
          AppRoutes.nutritionCalculatorScreen: (context) =>
              const NutritionCalculatorPage(),
          AppRoutes.graphAndReportsScreen: (context) =>
              const GraphAndReportsPage(),
          AppRoutes.exerciseLibraryScreen: (context) =>
              const ExerciseLibraryPage(),
          AppRoutes.passwordresetScreen: (context) =>
              const ResetPasswordScreen(),
          AppRoutes.emailVerificationScreen: (context) =>
              const EmailVerificationScreen(),
          AppRoutes.dayOverviewScreen: (context) => const DayOverviewPage(),
          AppRoutes.todayScreen: (context) => const TodayPage(),
          AppRoutes.dayCompletedScreen: (context) => const DayCompletedPage(),
          AppRoutes.exerciseScreen: (context) => const ExercisePage(),
          AppRoutes.recalculateScreen: (context) => const RecalculatePage(),
          AppRoutes.streakScreen: (context) => const StreakPage(),
          AppRoutes.calendarScreen: (context) => const CalendarPage(),
          AppRoutes.myProfileScreen: (context) => const MyProfilePage(),
        },
      ),
    );
  }
}
