import 'package:flutter_email_sender/flutter_email_sender.dart';

class EmailService {
  static Future sendEmail({
    required List<String> toEmails,
    required List<String> ccEmails,
    required String subject,
    required String body,
}) async {
    final Email email = Email(
      body: body,
      subject: subject,
      recipients: toEmails,
      cc: ccEmails,
      isHTML: false,
    );

    await FlutterEmailSender.send(email);
  }
}