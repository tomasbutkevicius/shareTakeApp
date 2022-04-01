import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_take/bloc/book_trade/book_trade_bloc.dart';
import 'package:share_take/bloc/helpers/bloc_getter.dart';
import 'package:share_take/bloc/helpers/request_status.dart';
import 'package:share_take/constants/enums.dart';
import 'package:share_take/constants/static_styles.dart';
import 'package:share_take/constants/theme/theme_colors.dart';
import 'package:share_take/data/models/trade/book_trade_local.dart';
import 'package:share_take/presentation/screens/trade_details/widgets/trade_item.dart';
import 'package:share_take/presentation/widgets/centered_loader.dart';
import 'package:share_take/presentation/widgets/custom_app_bar.dart';
import 'package:share_take/presentation/widgets/email_btn.dart';
import 'package:share_take/presentation/widgets/header.dart';
import 'package:share_take/presentation/widgets/proxy/button/proxy_button_widget.dart';
import 'package:share_take/presentation/widgets/proxy/spacing/proxy_spacing_widget.dart';
import 'package:share_take/presentation/widgets/proxy/text/proxy_text_widget.dart';
import 'package:share_take/presentation/widgets/utilities/static_widgets.dart';

class TradeDetailsOwnerScreen extends StatelessWidget {
  const TradeDetailsOwnerScreen({
    Key? key,
    required this.bookTrade,
  }) : super(key: key);
  static const String routeName = "/trade/details/owner";

  final BookTradeLocal bookTrade;

  List<DropdownMenuItem<TradeStatus>> get dropdownItems {
    List<DropdownMenuItem<TradeStatus>> menuItems = [
      DropdownMenuItem(
        child: ProxyTextWidget(text: "NEGOTIATING"),
        value: TradeStatus.negotiating,
      ),
      DropdownMenuItem(
        child: ProxyTextWidget(text: "SENDING"),
        value: TradeStatus.sending,
      ),
      DropdownMenuItem(
        child: ProxyTextWidget(text: "RECEIVED"),
        value: TradeStatus.received,
      ),
      DropdownMenuItem(
        child: ProxyTextWidget(text: "RETURNING"),
        value: TradeStatus.returning,
      ),
      DropdownMenuItem(
        child: ProxyTextWidget(text: "RETURNED"),
        value: TradeStatus.returned,
      ),
    ];
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    BlocGetter.getBookTradeBloc(context).add(BookTradeOpenEvent(selectedTrade: bookTrade));

    return Scaffold(
      appBar: CustomAppBar.build(
        context,
        backgroundColor: ThemeColors.light_blue.shade600,
        titleText: "Trade details",
      ),
      body: BlocConsumer<BookTradeBloc, BookTradeState>(
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
      ),
    );
  }

  Widget _buildTradeDetailsOwnerBody(BuildContext context, BookTradeState state) {
    if (state.trade == null) {
      return Container();
    }

    return ListView(
      padding: StaticStyles.listViewPadding,
      children: [
        Header(text: "You are owner of the trade item"),
        TradeItem(trade: state.trade!),
        ProxySpacingVerticalWidget(),
        ProxySpacingVerticalWidget(),
        Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(flex: 1, child: Icon(Icons.swap_horizontal_circle_outlined)),
            Expanded(flex: 2, child: _buildDropdown(state, context)),
          ],
        ),
        ProxySpacingVerticalWidget(),
        Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(flex: 1, child: Icon(Icons.email)),
            Expanded(
              flex: 2,
              child: EmailButtonWidget(
                buttonText: "Email receiver",
                toEmails: [
                  state.trade!.receiver.email,
                  state.trade!.owner.email,
                ],
                ccEmails: [
                  state.trade!.receiver.email,
                  state.trade!.owner.email,
                ],
                subject: '(Share Take App) Book Trade Message! Book: ' + state.trade!.book.title,
                body: "This message is from ShareTake app. \n\nI am owner of trade item.\n" +
                    "Trade information:\n" +
                    state.trade.toString(),
              ),
            ),
          ],
        ),
        ProxySpacingVerticalWidget(
          size: ProxySpacing.extraLarge,
        ),
      ],
    );
  }

  Widget _buildDropdown(BookTradeState state, BuildContext context) {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.orange, width: 2),
          borderRadius: BorderRadius.circular(20),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(20),
        ),
        filled: true,
        fillColor: ThemeColors.orange,
      ),
      style: TextStyle(
        color: Colors.white,
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
      dropdownColor: ThemeColors.orange.shade400,
      value: state.trade!.status,
      onChanged: (value) {
        if (value != null) {
          if (value as TradeStatus != state.trade!.status) {
            BlocGetter.getBookTradeBloc(context).add(BookTradeUpdateStatusEvent(status: value));
          }
        }
      },
      items: dropdownItems,
    );
  }
}
