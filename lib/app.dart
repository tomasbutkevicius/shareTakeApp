import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_take/bloc/navigation/navigation_bloc.dart';
import 'package:share_take/bloc/user/user_bloc.dart';
import 'package:share_take/constants/theme/theme.dart';
import 'package:share_take/presentation/routing/navigation_wrapper.dart';


class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      child: const AppView(),
      providers: [
        BlocProvider<NavigationBloc>(create: (_) => NavigationBloc()),
        BlocProvider<UserBloc>(create: (_) => UserBloc()),
      ],
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
      home: Stack(
        children: [
          const ListenerUserWidget(),
          NavigationWrapperWidget(),
        ],
      ),
    );
  }
}

class ListenerUserWidget extends StatelessWidget {
  const ListenerUserWidget({Key? key}) : super(key: key);

  void _listener(BuildContext context, UserState state) {
    //TODO: Reset blocs that depend on user
  }

  bool _listenWhen(UserState previousState, UserState state) => previousState.id != state.id;

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      child: SizedBox.shrink(),
      listener: _listener,
      listenWhen: _listenWhen,
    );
  }
}

