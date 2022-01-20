import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vms_visitor_flutter/app/data/constants.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: ThemeData(
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: kBlue,
          foregroundColor: kWhite,
        ),
        appBarTheme: const AppBarTheme(
          color: kBlue,
          foregroundColor: kWhite,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.w700,
            color: kWhite,
            fontSize: 20,
          ),
        ),
        scaffoldBackgroundColor: kLightBlue,
        colorScheme: ColorScheme(
          primary: kWhite,
          primaryVariant: kWhite,
          secondary: kLightBlue!,
          secondaryVariant: kBlue,
          surface: kLightBlue!,
          background: kLightBlue!,
          error: kRed,
          onPrimary: kGrey,
          onSecondary: kGrey,
          onSurface: kGrey,
          onBackground: kGrey,
          onError: kRed,
          brightness: Brightness.light,
        ),
      ),
    );
  }
}
