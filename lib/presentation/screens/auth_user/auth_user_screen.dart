import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_take/bloc/authentication/authentication_bloc.dart';
import 'package:share_take/constants/static_styles.dart';
import 'package:share_take/data/models/user/user_local.dart';
import 'package:share_take/presentation/widgets/custom_app_bar.dart';
import 'package:share_take/presentation/widgets/information_card.dart';
import 'package:share_take/presentation/widgets/proxy/text/proxy_text_widget.dart';

class AuthUserScreen extends StatelessWidget {
  const AuthUserScreen({Key? key}) : super(key: key);
  static const routeName = "/authuser";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.build(context),
      body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if(state.user == null) {
            return _noUserFoundWidget();
          }
          return _userWidget(state.user!);
        },
      ),
    );
  }

  Widget _noUserFoundWidget() {
    return const Center(
      child: InformationCard(message: "User info not found. Try logging back in",),
    );
  }

  Widget _userWidget(UserLocal userLocal) {
    return ListView(
      padding: StaticStyles.listViewPadding,
      children: [
        ProxyTextWidget(text: "Email: " + userLocal.email,),
        ProxyTextWidget(text: "First name: " + userLocal.firstName,),
        ProxyTextWidget(text: "Last name: " + userLocal.lastName,),
      ],
    );
  }
}
