import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_take/data/models/trade/book_trade_local.dart';
import 'package:share_take/presentation/screens/user_details/widgets/book_list_card_widget.dart';
import 'package:share_take/presentation/widgets/list_card.dart';
import 'package:share_take/presentation/widgets/proxy/spacing/proxy_spacing_widget.dart';
import 'package:share_take/presentation/widgets/proxy/text/proxy_text_widget.dart';
import 'package:share_take/presentation/widgets/user/user_list_card.dart';

class TradeItem extends StatelessWidget {
  const TradeItem({Key? key, required this.trade}) : super(key: key);

  final BookTradeLocal trade;

  @override
  Widget build(BuildContext context) {
      return ListCardWidget(
        child: Column(
          children: [
            ProxyTextWidget(text: "Owner"),
            UserListCardWidget(user: trade.owner),
            ProxySpacingVerticalWidget(),
            ProxyTextWidget(text: "Receiver"),
            UserListCardWidget(user: trade.receiver),
            ProxySpacingVerticalWidget(),
            ProxyTextWidget(text: "Offer"),
            BookListCardWidget(book: trade.book),
            ProxySpacingVerticalWidget(),
            ListTile(
              leading: Icon(Icons.swap_horiz),
              title: Text("STATUS: " + trade.status.name),
            ),
            ProxySpacingVerticalWidget(),
          ],
        ),
      );
  }
}
