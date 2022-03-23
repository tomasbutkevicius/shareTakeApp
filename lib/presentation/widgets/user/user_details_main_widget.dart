import 'package:flutter/material.dart';
import 'package:share_take/constants/enums.dart';
import 'package:share_take/constants/theme/theme_colors.dart';
import 'package:share_take/data/models/book/book_local.dart';
import 'package:share_take/data/models/user/user_local.dart';
import 'package:share_take/presentation/widgets/header.dart';
import 'package:share_take/presentation/widgets/proxy/spacing/proxy_spacing_widget.dart';
import 'package:share_take/presentation/widgets/proxy/text/proxy_text_widget.dart';
import 'package:share_take/presentation/widgets/utilities/static_widgets.dart';
import 'package:share_take/utilities/static_utilities.dart';

class UserDetailsMainWidget extends StatelessWidget {
  const UserDetailsMainWidget({Key? key, required this.user}) : super(key: key);
  final UserLocal user;

  @override
  Widget build(BuildContext context) {
    return _body(user);
  }

  Widget _body(UserLocal userLocal) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: ThemeColors.blue.shade500.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ProxyTextWidget(text: userLocal.email, fontSize: ProxyFontSize.large,),
              ProxySpacingVerticalWidget(),
              _getImage(userLocal),
              ProxySpacingVerticalWidget(),
           
              ListTile(
                leading: ProxyTextWidget(
                  text: "First name:",
                  fontWeight: ProxyFontWeight.bold,

                ),
                trailing: ProxyTextWidget(
                  text: userLocal.firstName,
                ),
              ),
              ListTile(
                leading: ProxyTextWidget(
                  text: "Last name:",
                  fontWeight: ProxyFontWeight.bold,

                ),
                trailing: ProxyTextWidget(
                  text: userLocal.lastName,
                ),
              ),
              ProxySpacingVerticalWidget(),
             
            ],
          ),
        ));
  }

  Container _getImage(UserLocal userLocal) {
    return Container(
      constraints: BoxConstraints(maxHeight: 100, maxWidth: 100),
      child: Icon(Icons.person)
    );
  }
  
}
