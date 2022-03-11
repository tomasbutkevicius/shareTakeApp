import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_take/bloc/book/book_bloc.dart';
import 'package:share_take/bloc/bottom_main_navigation/bottom_main_navigation_bloc.dart';
import 'package:share_take/constants/static_texts.dart';
import 'package:share_take/constants/theme/theme.dart';
import 'package:share_take/data/data_providers/local/local_user_source.dart';
import 'package:share_take/data/data_providers/remote/remote_book_source.dart';
import 'package:share_take/data/data_providers/remote/remote_user_source.dart';
import 'package:share_take/data/firebase_storage.dart';
import 'package:share_take/data/repositories/book_repository.dart';
import 'package:share_take/data/repositories/user_repository.dart';
import 'package:share_take/presentation/router/app_router.dart';

import 'bloc/authentication/authentication_bloc.dart';
import 'bloc/language_selection/language_selection_bloc.dart';

class MyApp extends StatelessWidget {
  final AppRouter appRouter;

  const MyApp({Key? key, required this.appRouter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => UserRepository(
            LocalUserSource(),
            RemoteUserSource(),
          ),
        ),
        RepositoryProvider(
          create: (context) => BookRepository(
            remoteBookSource: RemoteBookSource(),
            firebaseStorageService: FirebaseStorageService(),
          ),
        )
      ],
      child: Builder(builder: (context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<BottomMainNavigationBloc>(
              create: (_) => BottomMainNavigationBloc(),
            ),
            BlocProvider<LanguageSelectionBloc>(
              create: (_) => LanguageSelectionBloc(),
            ),
            BlocProvider<AuthenticationBloc>(
              create: (_) => AuthenticationBloc(
                context.read<UserRepository>(),
                BlocProvider.of<LanguageSelectionBloc>(_),
              )..add(
                  AppStarted(context),
                ),
            ),
            BlocProvider<BookBloc>(
              create: (_) => BookBloc(
                bookRepository: context.read<BookRepository>(),
              ),
            ),
          ],
          child: MaterialApp(
            title: StaticTexts.appTitle,
            theme: appTheme(),
            debugShowCheckedModeBanner: false,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            onGenerateRoute: appRouter.onGenerateRoute,
          ),
        );
      }),
    );
  }
}
