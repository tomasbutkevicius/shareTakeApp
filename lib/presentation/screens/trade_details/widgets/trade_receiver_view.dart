import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_take/bloc/book_trade/book_trade_bloc.dart';
import 'package:share_take/bloc/helpers/bloc_getter.dart';
import 'package:share_take/bloc/helpers/request_status.dart';
import 'package:share_take/constants/enums.dart';
import 'package:share_take/constants/static_styles.dart';
import 'package:share_take/data/models/trade/book_trade_local.dart';
import 'package:share_take/presentation/screens/trade_details/widgets/trade_item.dart';
import 'package:share_take/presentation/widgets/centered_loader.dart';
import 'package:share_take/presentation/widgets/email_btn.dart';
import 'package:share_take/presentation/widgets/header.dart';
import 'package:share_take/presentation/widgets/proxy/spacing/proxy_spacing_widget.dart';
import 'package:share_take/presentation/widgets/utilities/static_widgets.dart';

class TradeDetailsReceiverViewWidget extends StatelessWidget {
  const TradeDetailsReceiverViewWidget({
    Key? key,
    required this.bookTrade,
  }) : super(key: key);

  final BookTradeLocal bookTrade;

  @override
  Widget build(BuildContext context) {
    BlocGetter.getBookTradeBloc(context).add(BookTradeOpenEvent(selectedTrade: bookTrade));

    return BlocConsumer<BookTradeBloc, BookTradeState>(
      listener: (context, state) {
        if (state.status is RequestStatusSuccess) {
          StaticWidgets.showDefaultDialog(
            context: context,
            text: (state.status as RequestStatusSuccess).message,
          ).then(
            (value) => BlocGetter.getBookTradeBloc(context).add(
              BookTradeResetStatusEvent(),
            ),
          );
        }
        if (state.status is RequestStatusError) {
          StaticWidgets.showDefaultDialog(
            context: context,
            text: (state.status as RequestStatusError).message,
          ).then(
            (value) => BlocGetter.getBookTradeBloc(context).add(
              BookTradeResetStatusEvent(),
            ),
          );
        }
      },
      builder: (context, state) {
        RequestStatus requestStatus = state.status;
        BookTradeLocal? tradeItem = state.trade;

        return CenteredLoader(
          isLoading: requestStatus is RequestStatusLoading || tradeItem == null,
          child: _buildTradeDetailsOwnerBody(context, state),
        );
      },
    );
  }

  Widget _buildTradeDetailsOwnerBody(BuildContext context, BookTradeState state) {
    if (state.trade == null) {
      return Container();
    }

    return Padding(
      padding: StaticStyles.listViewPadding,
      child: Column(
        children: [
          Header(text: "You are receiver of trade item"),
          TradeItem(trade: state.trade!),
          ProxySpacingVerticalWidget(),
          Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(flex: 1, child: Icon(Icons.email)),
              Expanded(
                flex: 2,
                child: EmailButtonWidget(
                  buttonText: "Email owner",
                  toEmails: [
                    state.trade!.receiver.email,
                    state.trade!.owner.email,
                  ],
                  ccEmails: [
                    state.trade!.receiver.email,
                    state.trade!.owner.email,
                  ],
                  subject: 'Book Sharing! Book: ' + state.trade!.book.title,
                  body: "This message is from ShareTake app. \n\nI am receiver of trade item.\n" +
                      "Trade information:\n" +
                      state.trade.toString(),
                ),
              )
            ],
          ),
          ProxySpacingVerticalWidget(
            size: ProxySpacing.extraLarge,
          ),
        ],
      ),
    );
  }
}
