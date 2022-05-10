import 'package:flutter/material.dart';
import 'package:open_mail_app/open_mail_app.dart';
import 'package:share_take/constants/theme/theme_colors.dart';

import 'proxy/button/proxy_button_widget.dart';

class EmailButtonWidget extends StatefulWidget {
  const EmailButtonWidget({
    Key? key,
    required this.buttonText,
    required this.toEmails,
    required this.ccEmails,
    required this.subject,
    required this.body,
  }) : super(key: key);
  final String buttonText;
  final List<String> toEmails;
  final List<String> ccEmails;
  final String subject;
  final String body;

  @override
  _EmailButtonWidgetState createState() => _EmailButtonWidgetState();
}

class _EmailButtonWidgetState extends State<EmailButtonWidget> {
  @override
  Widget build(BuildContext context) {
    Color buttonColor = ThemeColors.light_blue.shade600;

    return ProxyButtonWidget(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 30,
      ),
      text: widget.buttonText,
      color: buttonColor,
      isUppercase: false,
      onPressed: () async {
        EmailContent email = EmailContent(
          to: widget.toEmails,
          subject: widget.subject,
          body: widget.body,
          cc: widget.ccEmails,
        );

        OpenMailAppResult result = await OpenMailApp.composeNewEmailInMailApp(
          nativePickerTitle: 'Select email app to compose',
          emailContent: email,
        );
        if (!result.didOpen && !result.canOpen) {
          showNoMailAppsDialog(context);
        } else if (!result.didOpen && result.canOpen) {
          showDialog(
            context: context,
            builder: (_) => MailAppPickerDialog(
              mailApps: result.options,
              emailContent: email,
            ),
          );
        }
      },
    );
    return ElevatedButton(
      child: Text(widget.buttonText),
      onPressed: () async {
        EmailContent email = EmailContent(
          to: widget.toEmails,
          subject: widget.subject,
          body: widget.body,
          cc: widget.ccEmails,
        );

        OpenMailAppResult result = await OpenMailApp.composeNewEmailInMailApp(
          nativePickerTitle: 'Select email app to compose',
          emailContent: email,
        );
        if (!result.didOpen && !result.canOpen) {
          showNoMailAppsDialog(context);
        } else if (!result.didOpen && result.canOpen) {
          showDialog(
            context: context,
            builder: (_) => MailAppPickerDialog(
              mailApps: result.options,
              emailContent: email,
            ),
          );
        }
      },
    );
  }

  void showNoMailAppsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Open Mail App"),
          content: Text("No mail apps installed"),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
}
