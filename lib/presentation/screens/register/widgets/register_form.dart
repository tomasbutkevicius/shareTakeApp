import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/src/provider.dart';
import 'package:share_take/bloc/authentication/authentication_bloc.dart';
import 'package:share_take/constants/enums.dart';
import 'package:share_take/constants/static_styles.dart';
import 'package:share_take/constants/theme/theme_colors.dart';
import 'package:share_take/presentation/widgets/proxy/button/proxy_button_widget.dart';
import 'package:share_take/presentation/widgets/proxy/input/proxy_text_form_field.dart';
import 'package:share_take/presentation/widgets/proxy/spacing/proxy_spacing_widget.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  late final TextEditingController _emailController = TextEditingController();
  late final TextEditingController _firstNameController = TextEditingController();
  late final TextEditingController _lastNameController = TextEditingController();
  late final TextEditingController _passwordController = TextEditingController();
  final focus = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: StaticStyles.listViewPadding,
        child: Column(
          children: <Widget>[
            _emailField(context),
            const ProxySpacingVerticalWidget(),
            _passwordField(context),
            const ProxySpacingVerticalWidget(),
            _firstNameField(context),
            const ProxySpacingVerticalWidget(),
            _lastNameField(context),
            const ProxySpacingVerticalWidget(
              size: ProxySpacing.extraLarge,
            ),
            _getSubmitBtn(context),
          ],
        ),
      ),
    );
  }

  Widget _passwordField(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 480.0),
            child: ProxyTextFormField(
              obscureText: true,
              controller: _passwordController,
              onFieldSubmitted: (v) {
                FocusScope.of(context).requestFocus(focus);
              },
              labelText: "Password",
              icon: Icon(
                Icons.security,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _emailField(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 480,
            ),
            child: ProxyTextFormField(
              controller: _emailController,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (v) {
                FocusScope.of(context).requestFocus(focus);
              },
              labelText: "Email",
              icon: Icon(
                Icons.email,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _firstNameField(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 480,
            ),
            child: ProxyTextFormField(
              controller: _firstNameController,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (v) {
                FocusScope.of(context).requestFocus(focus);
              },
              labelText: "First name",
              icon: Icon(
                Icons.person,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _lastNameField(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 480,
            ),
            child: ProxyTextFormField(
              controller: _lastNameController,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (v) {
                FocusScope.of(context).requestFocus(focus);
              },
              labelText: "Last name",
              icon: Icon(
                Icons.person,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _getSubmitBtn(BuildContext context) {
    String buttonText = "JOIN THE CLUB";
    return ProxyButtonWidget(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 100,
      ),
      text: buttonText,
      color: ThemeColors.blue.shade600,
      isUppercase: false,
      onPressed: () {
        context.read<AuthenticationBloc>().add(
          AuthRegisterEvent(
            email: _emailController.text,
            password: _passwordController.text,
            firstName: _firstNameController.text,
            lastName: _lastNameController.text,
            context: context,
          ),
        );
      },
    );
  }
}
