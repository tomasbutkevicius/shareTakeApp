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

class AddBookForm extends StatefulWidget {
  const AddBookForm({Key? key}) : super(key: key);

  @override
  _AddBookFormState createState() => _AddBookFormState();
}

class _AddBookFormState extends State<AddBookForm> {
  late final TextEditingController _isbnController = TextEditingController();
  late final TextEditingController _titleController = TextEditingController();
  late final TextEditingController _subtitleController = TextEditingController();
  late final TextEditingController _authorsController = TextEditingController();

  final focus = FocusNode();
/*  final String id;
  final int? isbn;
  final String title;
  final String? subtitle;
  final List<String> authors;
  final String? imageUrl;
  final String? language;
  final int pages;
  final DateTime publishDate;
  final String description;*/
  @override
  void dispose() {
    _isbnController.dispose();
    _authorsController.dispose();
    _titleController.dispose();
    _subtitleController.dispose();
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
              controller: _authorsController,
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
              controller: _isbnController,
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
              controller: _titleController,
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
              controller: _subtitleController,
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
    String buttonText = "Create";
    return ProxyButtonWidget(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 100,
      ),
      text: buttonText,
      color: ThemeColors.bordo.shade600,
      isUppercase: false,
      onPressed: () {
        context.read<AuthenticationBloc>().add(
          AuthRegisterEvent(
            email: _isbnController.text,
            password: _authorsController.text,
            firstName: _titleController.text,
            lastName: _subtitleController.text,
            context: context,
          ),
        );
      },
    );
  }
}
