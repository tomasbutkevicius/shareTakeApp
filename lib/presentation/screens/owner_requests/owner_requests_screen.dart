import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_take/bloc/helpers/bloc_getter.dart';
import 'package:share_take/bloc/helpers/request_status.dart';
import 'package:share_take/bloc/requests_as_owner/requests_as_owner_bloc.dart';
import 'package:share_take/constants/static_styles.dart';
import 'package:share_take/constants/theme/theme_colors.dart';
import 'package:share_take/data/models/book/book_request_local.dart';
import 'package:share_take/presentation/screens/user_details/widgets/book_list_card_widget.dart';
import 'package:share_take/presentation/widgets/centered_loader.dart';
import 'package:share_take/presentation/widgets/custom_app_bar.dart';
import 'package:share_take/presentation/widgets/header.dart';
import 'package:share_take/presentation/widgets/list_card.dart';
import 'package:share_take/presentation/widgets/proxy/spacing/proxy_spacing_widget.dart';
import 'package:share_take/presentation/widgets/proxy/text/proxy_text_widget.dart';
import 'package:share_take/presentation/widgets/user/user_list_card.dart';
import 'package:share_take/presentation/widgets/utilities/static_widgets.dart';

class OwnerRequestsScreen extends StatelessWidget {
  const OwnerRequestsScreen({Key? key}) : super(key: key);
  static const String routeName = "/requests/owner";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.build(
        context,
        backgroundColor: ThemeColors.darker_grey,
        titleText: "Requests incoming",
      ),
      body: BlocConsumer<RequestsAsOwnerBloc, RequestsAsOwnerState>(
        listener: (context, state) {
          if (state.status is RequestStatusSuccess) {
            StaticWidgets.showDefaultDialog(
              context: context,
              text: (state.status as RequestStatusSuccess).message,
            ).then(
              (value) => BlocGetter.getRequestsOwnerBloc(context).add(
                RequestsOwnerGetListEvent(),
              ),
            );
          }
        },
        builder: (context, state) {
          RequestStatus requestStatus = state.status;
          if (requestStatus is RequestStatusError) {
            return Center(child: ProxyTextWidget(text: "Encountered error\n" + requestStatus.message));
          }

          return CenteredLoader(
            isLoading: requestStatus is RequestStatusLoading,
            child: _buildRequestScreenBody(context, state),
          );
        },
      ),
    );
  }

  ListView _buildRequestScreenBody(BuildContext context, RequestsAsOwnerState state) {
    return ListView(
      padding: StaticStyles.listViewPadding,
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      children: [
        Header(text: "Received requests:"),
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
          ProxyTextWidget(text: "Owner (you)"),
          UserListCardWidget(user: request.owner),
          ProxySpacingVerticalWidget(),
          ProxyTextWidget(text: "Receiver"),
          UserListCardWidget(user: request.receiver),
          ProxySpacingVerticalWidget(),
          ProxyTextWidget(text: "Offer"),
          BookListCardWidget(book: request.book),
          ProxySpacingVerticalWidget(),
          ListTile(
            leading: Icon(Icons.swap_horiz),
            title: Text("STATUS: " + request.status.name),
          ),
        ],
      ),
    );
  }

}
