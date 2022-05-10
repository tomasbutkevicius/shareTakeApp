import 'package:flutter/material.dart';
import 'package:share_take/constants/theme/theme_colors.dart';
import 'package:share_take/data/models/trade/book_trade_local.dart';
import 'package:share_take/presentation/screens/trade_details/widgets/add_comment_widget.dart';
import 'package:share_take/presentation/screens/trade_details/widgets/trade_comments_widget.dart';
import 'package:share_take/presentation/screens/trade_details/widgets/trade_receiver_view.dart';
import 'package:share_take/presentation/widgets/custom_app_bar.dart';
import 'package:share_take/presentation/widgets/proxy/spacing/proxy_spacing_widget.dart';

class TradeDetailsReceiverScreen extends StatelessWidget {
  const TradeDetailsReceiverScreen({
    Key? key,
    required this.bookTrade,
  }) : super(key: key);
  static const String routeName = "/trade/details/receiver";

  final BookTradeLocal bookTrade;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar.build(
          context,
          backgroundColor: ThemeColors.light_blue.shade600,
          titleText: "Trade details",
        ),
        body: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: [
            TradeDetailsReceiverViewWidget(bookTrade: bookTrade),
            ProxySpacingVerticalWidget(),
            TradeCommentsWidget(bookTrade: bookTrade),
            AddCommentWidget(bookTrade: bookTrade),
          ],
        ));
  }
}
