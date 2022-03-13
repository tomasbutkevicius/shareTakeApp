import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_take/bloc/authentication/authentication_bloc.dart';
import 'package:share_take/bloc/helpers/bloc_getter.dart';
import 'package:share_take/bloc/helpers/request_status.dart';
import 'package:share_take/constants/static_styles.dart';
import 'package:share_take/constants/theme/theme_colors.dart';
import 'package:share_take/presentation/router/static_navigator.dart';
import 'package:share_take/presentation/screens/login/widgets/login_form.dart';
import 'package:share_take/presentation/widgets/custom_app_bar.dart';
import 'package:share_take/presentation/widgets/header.dart';
import 'package:share_take/presentation/widgets/information_card.dart';
import 'package:share_take/presentation/widgets/proxy/spacing/proxy_spacing_widget.dart';
import 'package:share_take/presentation/widgets/proxy/text/proxy_text_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const routeName = "/login";

  @override
  Widget build(BuildContext context) {
    String message = "";

    return Scaffold(
      appBar: CustomAppBar.build(context, backgroundColor: ThemeColors.blue.shade600),
      body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state.status is RequestStatusError) {
            RequestStatusError status = state.status as RequestStatusError;
            message = status.message;
          } else {
            message = "";
          }

          if (state.status is RequestStatusLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if(state.status is RequestStatusSuccess){
            BlocGetter.getAuthBloc(context).add(AuthResetStatusEvent());
            StaticNavigator.popUntilFirstRoute(context);
          }

          return Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    message.isEmpty
                        ? SizedBox.shrink()
                        : Padding(
                      padding: StaticStyles.contentPadding,
                      child: InkWell(
                        onTap: () {
                          BlocGetter.getAuthBloc(context).add(AuthResetStatusEvent());
                        },
                        child: InformationCard(
                          message: message,
                          backgroundColor: ThemeColors.blue.shade600,
                          textColor: ThemeColors.white,
                        ),
                      ),
                    ),
                    Header(text: "Login"),
                    ProxySpacingVerticalWidget(),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: 480.0,
                      ),
                      child: LoginForm(),
                    ),
                      ProxySpacingVerticalWidget(),
                      InkWell(
                        onTap: () {
                          StaticNavigator.pushRegisterScreen(context);
                        },
                        child: Padding(
                          padding: StaticStyles.contentPadding,
                          child: ProxyTextWidget(
                            color: ThemeColors.orange,
                            text: "Register",
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
        },
      ),
    );
  }

}
