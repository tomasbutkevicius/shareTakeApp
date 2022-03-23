import 'package:flutter/material.dart';
import 'package:share_take/bloc/book_details/book_details_bloc.dart';
import 'package:share_take/bloc/helpers/bloc_getter.dart';
import 'package:share_take/bloc/helpers/request_status.dart';
import 'package:share_take/constants/enums.dart';
import 'package:share_take/constants/static_styles.dart';
import 'package:share_take/constants/theme/theme_colors.dart';
import 'package:share_take/data/models/user/user_local.dart';
import 'package:share_take/presentation/widgets/custom_app_bar.dart';
import 'package:share_take/presentation/widgets/header.dart';
import 'package:share_take/presentation/widgets/proxy/spacing/proxy_spacing_widget.dart';
import 'package:share_take/presentation/widgets/proxy/text/proxy_text_widget.dart';
import 'package:share_take/presentation/widgets/user/user_details_main_widget.dart';
import 'package:share_take/presentation/widgets/user/user_list_card.dart';

class UserDetailsScreen extends StatelessWidget {
  const UserDetailsScreen({
    Key? key,
    required this.user,
  }) : super(key: key);
  static const String routeName = "/user/details";

  final UserLocal user;

  @override
  Widget build(BuildContext context) {

    BlocGetter.getBookDetailsBloc(context).add(BookDetailsGetEvent(bookId: user.id));

    return Scaffold(
      appBar: CustomAppBar.build(context, backgroundColor: ThemeColors.bordo.shade600),
      body: Center(
        child: ListView(
          padding: StaticStyles.listViewPadding,
          children: <Widget>[
            ProxySpacingVerticalWidget(),
            UserDetailsMainWidget(user: user),
            ProxySpacingVerticalWidget(
              size: ProxySpacing.large,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMoreDetails(BuildContext context, BookDetailsState state) {
    String message = "";

    if(state.status is RequestStatusError){
      message = (state.status as RequestStatusError).message;
    }

    return ListView(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      children: [

        message.isNotEmpty ? ProxyTextWidget(text: message) : SizedBox.shrink(),
        Header(text: "Wanted by:"),
        ListView.builder(
          shrinkWrap: true,
          itemCount: state.wantedByUsersList.length,
          itemBuilder: (context, index) {
            UserLocal userThatNeedsBook = state.wantedByUsersList[index];
            return UserListCardWidget(user: userThatNeedsBook);
          },
        ),
      ],
    );
  }
}
