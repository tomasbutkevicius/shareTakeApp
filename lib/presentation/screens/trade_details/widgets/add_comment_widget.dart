import 'package:flutter/material.dart';
import 'package:share_take/bloc/helpers/bloc_getter.dart';
import 'package:share_take/bloc/trade_comments/trade_comments_bloc.dart';
import 'package:share_take/constants/static_styles.dart';
import 'package:share_take/constants/theme/theme_colors.dart';
import 'package:share_take/data/models/trade/book_trade_local.dart';
import 'package:share_take/presentation/widgets/proxy/button/proxy_button_widget.dart';
import 'package:share_take/presentation/widgets/proxy/spacing/proxy_spacing_widget.dart';

import '../../../widgets/proxy/input/proxy_text_form_field.dart';

class AddCommentWidget extends StatefulWidget {
  const AddCommentWidget({
    Key? key,
    required this.bookTrade,
  }) : super(key: key);

  final BookTradeLocal bookTrade;

  @override
  State<AddCommentWidget> createState() => _AddCommentWidgetState();
}

class _AddCommentWidgetState extends State<AddCommentWidget> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController commentController;

  @override
  void initState() {
    commentController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(padding: StaticStyles.listViewPadding, child: _messageForm(context));
  }

  Widget _messageForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _messageField(),
          const ProxySpacingVerticalWidget(),
          _getSubmitBtn(
            context,
          ),
          const ProxySpacingVerticalWidget(),

        ],
      ),
    );
  }

  Widget _messageField() {
    return Column(children: [
      const ProxySpacingVerticalWidget(),
      ProxyTextFormField(
        labelText: "Message",
        controller: commentController,
        keyboardType: TextInputType.multiline,
        validator: (_) {
          if (commentController.text.trim().isEmpty) {
            return "Message cannot be empty";
          }
          return null;
        },
      ),
    ]);
  }

  Widget _getSubmitBtn(BuildContext context) {
    String buttonText = "Submit";

    return ProxyButtonWidget(
      padding: StaticStyles.contentPadding,
      text: buttonText,
      color: ThemeColors.blue,
      isUppercase: false,
      onPressed: () {
        FocusScope.of(context).requestFocus(FocusNode());
        if (_formKey.currentState!.validate()) {
          BlocGetter.getTradeCommentsBloc(context).add(
            TradeCommentsCreateEvent(
              text: commentController.text,
              tradeId: widget.bookTrade.id,
            ),
          );
          commentController.clear();
        }
      },
    );
  }
}
