import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:german_board/Constants/color.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Bindings/initial_bindings.dart';
import 'Constants/app_routes.dart';
import 'Services/hive_service.dart';
import 'Services/lifecycel.dart';
import 'Services/notification_service.dart';
import 'Services/stripe_services.dart';
import 'firebase_options.dart';
import 'l10n/app_localizations.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    final savedThemeMode = await AdaptiveTheme.getThemeMode();
    Stripe.publishableKey=stripePublishableKey;
    await Stripe.instance.applySettings();
    final prefs = await SharedPreferences.getInstance();
    String? savedLangCode = prefs.getString('selected_language_code');
    Locale initialLocale = savedLangCode != null ? Locale(savedLangCode) : const Locale('en');
    await HiveService.init();
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    await NotificationService.init();
  runApp(AppLifecycleReactor(
    child: MyApp(
      savedThemeMode: savedThemeMode, initialLocale: initialLocale,
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.savedThemeMode, required this.initialLocale});
  final AdaptiveThemeMode? savedThemeMode;
  final Locale initialLocale;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    if (orientation == Orientation.portrait) {
    ScreenUtil.init(context, designSize: Size(393, 852));
    } else {
    ScreenUtil.init(context, designSize: Size(852, 393));
     }
       return
         AdaptiveTheme(
           light: AppTheme.lightTheme,
           dark: AppTheme.darkTheme,
           initial: savedThemeMode ?? AdaptiveThemeMode.light,
           builder: (ThemeData light, ThemeData dark) =>
         GetMaterialApp(
             theme: light,
         darkTheme: dark,
         debugShowCheckedModeBanner: false,
           locale: initialLocale,
           localizationsDelegates: const [
            AppLocalizations.delegate,
             GlobalMaterialLocalizations.delegate,
             GlobalWidgetsLocalizations.delegate,
             GlobalCupertinoLocalizations.delegate,
           ],
           supportedLocales: AppLocalizations.supportedLocales,
         initialRoute: AppRoutes.initial,
         initialBinding: InitialBindings(),
         getPages: AppRoutes.routes,
       ),);

  }
}
