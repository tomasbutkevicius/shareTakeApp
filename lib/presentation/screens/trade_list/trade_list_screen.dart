import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_take/bloc/book_trade_list/book_trade_list_bloc.dart';
import 'package:share_take/bloc/helpers/bloc_getter.dart';
import 'package:share_take/bloc/helpers/request_status.dart';
import 'package:share_take/constants/static_styles.dart';
import 'package:share_take/constants/theme/theme_colors.dart';
import 'package:share_take/data/models/trade/book_trade_local.dart';
import 'package:share_take/presentation/router/static_navigator.dart';
import 'package:share_take/presentation/screens/user_details/widgets/book_list_card_widget.dart';
import 'package:share_take/presentation/widgets/centered_loader.dart';
import 'package:share_take/presentation/widgets/custom_app_bar.dart';
import 'package:share_take/presentation/widgets/header.dart';
import 'package:share_take/presentation/widgets/list_card.dart';
import 'package:share_take/presentation/widgets/proxy/button/proxy_button_widget.dart';
import 'package:share_take/presentation/widgets/proxy/spacing/proxy_spacing_widget.dart';
import 'package:share_take/presentation/widgets/proxy/text/proxy_text_widget.dart';
import 'package:share_take/presentation/widgets/user/user_list_card.dart';
import 'package:share_take/presentation/widgets/utilities/static_widgets.dart';

class TradeListScreen extends StatelessWidget {
  const TradeListScreen({Key? key}) : super(key: key);
  static const String routeName = "/trades";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.build(
        context,
        backgroundColor: ThemeColors.light_blue.shade600,
        titleText: "Trades",
      ),
      body: BlocConsumer<BookTradeListBloc, BookTradeListState>(
        listener: (context, state) {
          if (state.status is RequestStatusSuccess) {
            StaticWidgets.showDefaultDialog(
              context: context,
              text: (state.status as RequestStatusSuccess).message,
            ).then(
                  (value) => BlocGetter.getBookTradeListBloc(context).add(
                BookTradeListResetStatusEvent(),
              ),
            );
          }
          if (state.status is RequestStatusError) {
            StaticWidgets.showDefaultDialog(
              context: context,
              text: (state.status as RequestStatusError).message,
            ).then(
                  (value) => BlocGetter.getBookTradeListBloc(context).add(
                    BookTradeListResetStatusEvent(),
              ),
            );
          }
        },
        builder: (context, state) {
          RequestStatus requestStatus = state.status;

          return CenteredLoader(
            isLoading: requestStatus is RequestStatusLoading,
            child: _buildTradeListScreenBody(context, state),
          );
        },
      ),
    );
  }

  ListView _buildTradeListScreenBody(BuildContext context, BookTradeListState state) {
    return ListView(
      padding: StaticStyles.listViewPadding,
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      children: [
        state.tradeList.isEmpty ? Header(text: "No trades found") : SizedBox.shrink(),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: state.tradeList.length,
          itemBuilder: (context, index) {
            BookTradeLocal trade = state.tradeList[index];
            return _getTradeListItem(trade, context);
          },
        ),
        ProxySpacingVerticalWidget(),
      ],
    );
  }

  Widget _getTradeListItem(BookTradeLocal trade, BuildContext context) {
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
          _getOpenTradeBtn(context, trade),
        ],
      ),
    );
  }
  
  Widget _getOpenTradeBtn(BuildContext context, BookTradeLocal trade) {
    String buttonText = "Details";

    Color buttonColor = ThemeColors.orange.shade600;
    return ProxyButtonWidget(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 100,
      ),
      text: buttonText,
      color: buttonColor,
      isUppercase: false,
      onPressed: () {
        StaticNavigator.pushTradeDetailsScreen(context, trade);
      },
    );
  }
}
