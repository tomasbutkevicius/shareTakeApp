import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_take/bloc/book_want/book_want_bloc.dart';
import 'package:share_take/bloc/helpers/bloc_getter.dart';
import 'package:share_take/bloc/helpers/request_status.dart';
import 'package:share_take/bloc/user_offer/user_offer_bloc.dart';
import 'package:share_take/bloc/user_want/user_want_bloc.dart';
import 'package:share_take/constants/enums.dart';
import 'package:share_take/constants/static_styles.dart';
import 'package:share_take/constants/theme/theme_colors.dart';
import 'package:share_take/data/models/book/book_local.dart';
import 'package:share_take/data/models/user/user_local.dart';
import 'package:share_take/presentation/screens/user_details/widgets/book_list_card_widget.dart';
import 'package:share_take/presentation/widgets/centered_loader.dart';
import 'package:share_take/presentation/widgets/custom_app_bar.dart';
import 'package:share_take/presentation/widgets/header.dart';
import 'package:share_take/presentation/widgets/list_card.dart';
import 'package:share_take/presentation/widgets/proxy/spacing/proxy_spacing_widget.dart';
import 'package:share_take/presentation/widgets/proxy/text/proxy_text_widget.dart';
import 'package:share_take/presentation/widgets/user/user_details_main_widget.dart';

class UserDetailsScreen extends StatelessWidget {
  const UserDetailsScreen({
    Key? key,
    required this.user,
  }) : super(key: key);
  static const String routeName = "/user/details";

  final UserLocal user;

  @override
  Widget build(BuildContext context) {
    BlocGetter.getUserWantBloc(context).add(UserWantGetEvent(userId: user.id));
    BlocGetter.getUserOfferBloc(context).add(UserOfferGetEvent(userId: user.id));

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
            Header(text: "Wanted books:"),

            BlocBuilder<UserWantBloc, UserWantState>(
              builder: (context, state) {
                if (state.status is RequestStatusError) {
                  return Center(
                    child: ProxyTextWidget(text: "Encountered error \n" + (state.status as RequestStatusError).message),
                  );
                }
                return CenteredLoader(
                  isLoading: state.status is RequestStatusLoading,
                  child: _buildBookWishes(context, state),
                );
              },
            ),
            Header(text: "Offered books:"),

            BlocBuilder<UserOfferBloc, UserOfferState>(
              builder: (context, state) {
                if (state.status is RequestStatusError) {
                  return Center(
                    child: ProxyTextWidget(text: "Encountered error \n" + (state.status as RequestStatusError).message),
                  );
                }
                return CenteredLoader(
                  isLoading: state.status is RequestStatusLoading,
                  child: _buildBookOffers(context, state),
                );
              },
            ),
            ProxySpacingVerticalWidget(
              size: ProxySpacing.large,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookWishes(BuildContext context, UserWantState state) {
    return ListView(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      children: [
        state.wantedBooks.isEmpty ? ProxyTextWidget(text: "No wanted books found") : SizedBox.shrink(),
        ListView.builder(
          shrinkWrap: true,
          itemCount: state.wantedBooks.length,
          itemBuilder: (context, index) {
            BookLocal book = state.wantedBooks[index];
            return _getWantedListItem(book);
          },
        ),
      ],
    );
  }

  Widget _getWantedListItem(BookLocal bookWanted) {
    return ListCardWidget(
      child: Column(
        children: [
          BookListCardWidget(book: bookWanted),
        ],
      ),
    );
  }

  Widget _buildBookOffers(BuildContext context, UserOfferState state) {
    return ListView(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      children: [
        state.offeredBooks.isEmpty ? ProxyTextWidget(text: "No offered books found") : SizedBox.shrink(),
        ListView.builder(
          shrinkWrap: true,
          itemCount: state.offeredBooks.length,
          itemBuilder: (context, index) {
            BookLocal book = state.offeredBooks[index];
            return _getOfferListItem(book);
          },
        ),
      ],
    );
  }

  Widget _getOfferListItem(BookLocal bookWanted) {
    return ListCardWidget(
      child: Column(
        children: [
          BookListCardWidget(book: bookWanted),
        ],
      ),
    );
  }
}
