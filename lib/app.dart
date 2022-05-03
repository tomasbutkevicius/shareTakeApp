import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_take/bloc/book_list/book_list_bloc.dart';
import 'package:share_take/bloc/book_offer/book_offer_bloc.dart';
import 'package:share_take/bloc/book_trade/book_trade_bloc.dart';
import 'package:share_take/bloc/book_trade_list/book_trade_list_bloc.dart';
import 'package:share_take/bloc/book_want/book_want_bloc.dart';
import 'package:share_take/bloc/bottom_main_navigation/bottom_main_navigation_bloc.dart';
import 'package:share_take/bloc/requests_as_owner/requests_as_owner_bloc.dart';
import 'package:share_take/bloc/requests_as_receiver/requests_as_receiver_bloc.dart';
import 'package:share_take/bloc/trade_comments/trade_comments_bloc.dart';
import 'package:share_take/bloc/user_list/user_list_bloc.dart';
import 'package:share_take/bloc/user_offer/user_offer_bloc.dart';
import 'package:share_take/constants/static_texts.dart';
import 'package:share_take/constants/theme/theme.dart';
import 'package:share_take/data/data_providers/local/local_user_source.dart';
import 'package:share_take/data/data_providers/remote/remote_book_request_source.dart';
import 'package:share_take/data/data_providers/remote/remote_book_source.dart';
import 'package:share_take/data/data_providers/remote/remote_book_trade_source.dart';
import 'package:share_take/data/data_providers/remote/remote_comment_source.dart';
import 'package:share_take/data/data_providers/remote/remote_offer_source.dart';
import 'package:share_take/data/data_providers/remote/remote_user_source.dart';
import 'package:share_take/data/data_providers/remote/remote_wishlist_source.dart';
import 'package:share_take/data/firebase_storage.dart';
import 'package:share_take/data/repositories/book_repository.dart';
import 'package:share_take/data/repositories/book_request_repository.dart';
import 'package:share_take/data/repositories/comment_repository.dart';
import 'package:share_take/data/repositories/trade_repository.dart';
import 'package:share_take/data/repositories/user_repository.dart';
import 'package:share_take/presentation/router/app_router.dart';

import 'bloc/authentication/authentication_bloc.dart';
import 'bloc/language_selection/language_selection_bloc.dart';
import 'bloc/user_want/user_want_bloc.dart';

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
            RemoteUserSource(
              fireStore: FirebaseFirestore.instance,
              firebaseAuth: FirebaseAuth.instance,
            ),
            RemoteWishListSource(
              fireStore: FirebaseFirestore.instance,
            ),
            RemoteOfferSource(
              fireStore: FirebaseFirestore.instance,
            ),
          ),
        ),
        RepositoryProvider(
          create: (context) => BookRepository(
            remoteOfferSource: RemoteOfferSource(),
            remoteWishListSource: RemoteWishListSource(),
            remoteBookSource: RemoteBookSource(),
            firebaseStorageService: FirebaseStorageService(),
          ),
        ),
        RepositoryProvider(
          create: (context) => BookRequestRepository(
            remoteOfferSource: RemoteOfferSource(),
            remoteBookRequestSource: RemoteBookRequestSource(
              fireStore: FirebaseFirestore.instance,
            ),
          ),
        ),
        RepositoryProvider(
          create: (context) => TradeRepository(
            remoteOfferSource: RemoteOfferSource(),
            remoteBookRequestSource: RemoteBookRequestSource(
              fireStore: FirebaseFirestore.instance,
            ),
            remoteBookTradeSource: RemoteBookTradeSource(
              fireStore: FirebaseFirestore.instance,
            ),
          ),
        ),
        RepositoryProvider(
          create: (context) => CommentRepository(
            remoteCommentSource: RemoteCommentSource(
              fireStore: FirebaseFirestore.instance,
            ),
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
                  AuthAppStarted(context),
                ),
            ),
            BlocProvider<UserListBloc>(
              create: (_) => UserListBloc(
                userRepository: context.read<UserRepository>(),
              ),
            ),
            BlocProvider<BookListBloc>(
              create: (_) => BookListBloc(
                authenticationBloc: BlocProvider.of<AuthenticationBloc>(_),
                bookRepository: context.read<BookRepository>(),
              ),
            ),
            BlocProvider<BookWantBloc>(
              create: (_) => BookWantBloc(
                authenticationBloc: BlocProvider.of<AuthenticationBloc>(_),
                bookRepository: context.read<BookRepository>(),
                userRepository: context.read<UserRepository>(),
              ),
            ),
            BlocProvider<BookOfferBloc>(
              create: (_) => BookOfferBloc(
                authenticationBloc: BlocProvider.of<AuthenticationBloc>(_),
                bookRepository: context.read<BookRepository>(),
                userRepository: context.read<UserRepository>(),
                tradeRepository: context.read<BookRequestRepository>(),
              ),
            ),
            BlocProvider<UserWantBloc>(
              create: (_) => UserWantBloc(
                authenticationBloc: BlocProvider.of<AuthenticationBloc>(_),
                bookRepository: context.read<BookRepository>(),
                userRepository: context.read<UserRepository>(),
              ),
            ),
            BlocProvider<UserOfferBloc>(
              create: (_) => UserOfferBloc(
                authenticationBloc: BlocProvider.of<AuthenticationBloc>(_),
                bookRepository: context.read<BookRepository>(),
                userRepository: context.read<UserRepository>(),
              ),
            ),
            BlocProvider<RequestsAsReceiverBloc>(
              create: (_) => RequestsAsReceiverBloc(
                authenticationBloc: BlocProvider.of<AuthenticationBloc>(_),
                bookRepository: context.read<BookRepository>(),
                userRepository: context.read<UserRepository>(),
                requestRepository: context.read<BookRequestRepository>(),
                tradeRepository: context.read<TradeRepository>(),
              ),
            ),
            BlocProvider<RequestsAsOwnerBloc>(
              create: (_) => RequestsAsOwnerBloc(
                authenticationBloc: BlocProvider.of<AuthenticationBloc>(_),
                bookRepository: context.read<BookRepository>(),
                userRepository: context.read<UserRepository>(),
                requestRepository: context.read<BookRequestRepository>(),
                tradeRepository: context.read<TradeRepository>(),
              ),
            ),
            BlocProvider<BookTradeListBloc>(
              create: (_) => BookTradeListBloc(
                authenticationBloc: BlocProvider.of<AuthenticationBloc>(_),
                bookRepository: context.read<BookRepository>(),
                userRepository: context.read<UserRepository>(),
                tradeRepository: context.read<TradeRepository>(),
              ),
            ),
            BlocProvider<BookTradeBloc>(
              create: (_) => BookTradeBloc(
                authenticationBloc: BlocProvider.of<AuthenticationBloc>(_),
                tradeRepository: context.read<TradeRepository>(),
                bookTradeListBloc: BlocProvider.of<BookTradeListBloc>(_),
              ),
            ),
            BlocProvider<TradeCommentsBloc>(
              create: (_) => TradeCommentsBloc(
                authenticationBloc: BlocProvider.of<AuthenticationBloc>(_),
                commentRepository: context.read<CommentRepository>(),
              ),
            ),
          ],
          child: BlocListener<AuthenticationBloc, AuthenticationState>(
            listener: _listener,
            listenWhen: _listenWhen,
            child: MaterialApp(
              title: StaticTexts.appTitle,
              theme: appTheme(),
              debugShowCheckedModeBanner: false,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              onGenerateRoute: appRouter.onGenerateRoute,
            ),
          ),
        );
      }),
    );
  }

  void _listener(BuildContext context, AuthenticationState state) {
    context.read<BookListBloc>().add(BookListResetEvent());
  }

  bool _listenWhen(AuthenticationState previousState, AuthenticationState state) => previousState.user != state.user;
}
