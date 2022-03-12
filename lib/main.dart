import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:share_take/app.dart';
import 'package:share_take/constants/static_localization.dart';
import 'package:share_take/constants/static_paths.dart';
import 'package:share_take/presentation/router/app_router.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      path: StaticPaths.translations,
      supportedLocales: StaticLocalization.supportedLocales,
      startLocale: StaticLocalization.englishLocale,
      fallbackLocale: StaticLocalization.englishLocale,
      useFallbackTranslations: true,
      child: MyApp(
        appRouter: AppRouter(),
      ),
    ),
  );
}
