import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_take/bloc/helpers/bloc_getter.dart';
import 'package:share_take/bloc/helpers/request_status.dart';
import 'package:share_take/bloc/requests_as_owner/requests_as_owner_bloc.dart';
import 'package:share_take/bloc/requests_as_receiver/requests_as_receiver_bloc.dart';
import 'package:share_take/constants/enums.dart';
import 'package:share_take/constants/static_styles.dart';
import 'package:share_take/constants/theme/theme_colors.dart';
import 'package:share_take/data/models/book/book_request_local.dart';
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

class ReceiverRequestsScreen extends StatelessWidget {
  const ReceiverRequestsScreen({Key? key}) : super(key: key);
  static const String routeName = "/requests/receiver";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.build(
        context,
        backgroundColor: ThemeColors.darker_grey,
        titleText: "Requests pending",
      ),
      body: BlocConsumer<RequestsAsReceiverBloc, RequestsAsReceiverState>(
        listener: (context, state) {
          if (state.status is RequestStatusSuccess) {
            StaticWidgets.showDefaultDialog(
              context: context,
              text: (state.status as RequestStatusSuccess).message,
            ).then(
              (value) => BlocGetter.getRequestsReceiverBloc(context).add(
                RequestsReceiverResetStatusEvent(),
              ),
            );
          }
          if (state.status is RequestStatusError) {
            StaticWidgets.showDefaultDialog(
              context: context,
              text: (state.status as RequestStatusError).message,
            ).then(
                  (value) => BlocGetter.getRequestsReceiverBloc(context).add(
                    RequestsReceiverResetStatusEvent(),
              ),
            );
          }
        },
        builder: (context, state) {
          RequestStatus requestStatus = state.status;

          return CenteredLoader(
            isLoading: requestStatus is RequestStatusLoading,
            child: _buildRequestScreenBody(context, state),
          );
        },
      ),
    );
  }

  ListView _buildRequestScreenBody(BuildContext context, RequestsAsReceiverState state) {
    return ListView(
      padding: StaticStyles.listViewPadding,
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      children: [
        Header(text: "You have requested:"),
        state.requestList.isEmpty ? ProxyTextWidget(text: "No requests found") : SizedBox.shrink(),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: state.requestList.length,
          itemBuilder: (context, index) {
            BookRequestLocal request = state.requestList[index];
            return _getRequestListItem(request, context);
          },
        ),
        ProxySpacingVerticalWidget(),
      ],
    );
  }

  Widget _getRequestListItem(BookRequestLocal request, BuildContext context) {
    return ListCardWidget(
      child: Column(
        children: [
          ProxyTextWidget(text: "Owner"),
          UserListCardWidget(user: request.owner),
          ProxySpacingVerticalWidget(),
          ProxyTextWidget(text: "Receiver (you)"),
          UserListCardWidget(user: request.receiver),
          ProxySpacingVerticalWidget(),
          ProxyTextWidget(text: "Offer"),
          BookListCardWidget(book: request.book),
          ProxySpacingVerticalWidget(),
          ListTile(
            leading: Icon(Icons.swap_horiz),
            title: Text("STATUS: " + request.status.name),
          ),
          ProxySpacingVerticalWidget(),
          request.status == BookRequestStatus.accepted ? _getCreateTradeBtn(context, request) : SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget _getCreateTradeBtn(BuildContext context, BookRequestLocal requestLocal) {
    String buttonText = "Start Trade";
    Color buttonColor = ThemeColors.blue.shade600;
    return ProxyButtonWidget(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 100,
      ),
      text: buttonText,
      color: buttonColor,
      isUppercase: false,
      onPressed: () {
        context.read<RequestsAsReceiverBloc>().add(
          RequestsReceiverCreateBookTradeEvent(
                requestLocal: requestLocal,
              ),
            );
      },
    );
  }
}
