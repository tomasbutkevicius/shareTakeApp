import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_take/bloc/book_offer/book_offer_bloc.dart';
import 'package:share_take/bloc/book_want/book_want_bloc.dart';
import 'package:share_take/bloc/helpers/bloc_getter.dart';
import 'package:share_take/bloc/helpers/request_status.dart';
import 'package:share_take/constants/enums.dart';
import 'package:share_take/constants/static_styles.dart';
import 'package:share_take/constants/theme/theme_colors.dart';
import 'package:share_take/data/models/book/book_local.dart';
import 'package:share_take/data/models/book_offers/book_offer_local.dart';
import 'package:share_take/data/models/user/user_local.dart';
import 'package:share_take/presentation/widgets/book/book_details_main_widget.dart';
import 'package:share_take/presentation/widgets/centered_loader.dart';
import 'package:share_take/presentation/widgets/custom_app_bar.dart';
import 'package:share_take/presentation/widgets/header.dart';
import 'package:share_take/presentation/widgets/list_card.dart';
import 'package:share_take/presentation/widgets/proxy/button/proxy_button_widget.dart';
import 'package:share_take/presentation/widgets/proxy/spacing/proxy_spacing_widget.dart';
import 'package:share_take/presentation/widgets/proxy/text/proxy_text_widget.dart';
import 'package:share_take/presentation/widgets/user/user_list_card.dart';
import 'package:share_take/presentation/widgets/utilities/static_widgets.dart';

class BookDetailsScreen extends StatelessWidget {
  const BookDetailsScreen({
    Key? key,
    required this.bookLocal,
  }) : super(key: key);
  static const String routeName = "/book";

  final BookLocal bookLocal;

  @override
  Widget build(BuildContext context) {
    BlocGetter.getBookWantBloc(context).add(BookWantGetEvent(bookId: bookLocal.id));
    BlocGetter.getBookOfferBloc(context).add(BookOfferGetEvent(bookId: bookLocal.id));

    return MultiBlocListener(
      listeners: [
        BlocListener<BookOfferBloc, BookOfferState>(
          listener: (context, state) {
            RequestStatus status = state.status;
            if (status is RequestStatusSuccess) {
              StaticWidgets.showDefaultDialog(
                context: context,
                text: (status).message,
              ).then((value) {
                BlocGetter.getBookOfferBloc(context).add(BookOfferStatusResetEvent());
              });
            }
            if (status is RequestStatusError) {
              StaticWidgets.showDefaultDialog(
                context: context,
                text: (status).message,
              ).then((value) {
                BlocGetter.getBookOfferBloc(context).add(BookOfferStatusResetEvent());
              });
            }
          },
        ),
        BlocListener<BookWantBloc, BookWantState>(
          listener: (context, state) {
            RequestStatus status = state.status;
            if (status is RequestStatusSuccess) {
              StaticWidgets.showDefaultDialog(
                context: context,
                text: (status).message,
              ).then((value) {
                BlocGetter.getBookWantBloc(context).add(BookWantStatusResetEvent());
              });
            }
            if (status is RequestStatusError) {
              StaticWidgets.showDefaultDialog(
                context: context,
                text: (status).message,
              ).then((value) {
                BlocGetter.getBookWantBloc(context).add(BookWantStatusResetEvent());
              });
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: CustomAppBar.build(context, backgroundColor: ThemeColors.bordo.shade600),
        body: Center(
          child: ListView(
            padding: StaticStyles.listViewPadding,
            children: <Widget>[
              ProxySpacingVerticalWidget(),
              BookDetailsMainWidget(bookLocal: bookLocal),
              ProxySpacingVerticalWidget(
                size: ProxySpacing.large,
              ),
              BlocBuilder<BookWantBloc, BookWantState>(
                builder: (context, state) {
                  return CenteredLoader(
                    isLoading: state is RequestStatusLoading,
                    child: _getWantBtn(state, context),
                  );
                },
              ),
              BlocBuilder<BookOfferBloc, BookOfferState>(
                builder: (context, state) {
                  return CenteredLoader(
                    isLoading: state.status is RequestStatusLoading,
                    child: _getOfferBtn(state, context),
                  );
                },
              ),
              BlocBuilder<BookWantBloc, BookWantState>(
                builder: (context, state) {
                  return CenteredLoader(
                    isLoading: state.status is RequestStatusLoading,
                    child: _buildBookWantedBy(context, state),
                  );
                },
              ),
              ProxySpacingVerticalWidget(
                size: ProxySpacing.large,
              ),
              BlocBuilder<BookOfferBloc, BookOfferState>(
                builder: (context, state) {
                  return CenteredLoader(
                    isLoading: state.status is RequestStatusLoading,
                    child: _buildBookOfferedBy(context, state),
                  );
                },
              ),
              ProxySpacingVerticalWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBookWantedBy(BuildContext context, BookWantState state) {
    return ListView(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      children: [
        Header(text: "Wanted by:"),
        state.wantedByUsersList.isEmpty ? ProxyTextWidget(text: "No users found") : SizedBox.shrink(),
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: state.wantedByUsersList.length,
          itemBuilder: (context, index) {
            UserLocal userThatNeedsBook = state.wantedByUsersList[index];
            return _getWantedByListItem(userThatNeedsBook);
          },
        ),
      ],
    );
  }

  Widget _buildBookOfferedBy(BuildContext context, BookOfferState state) {
    String message = "";

    if (state.status is RequestStatusError) {
      message = (state.status as RequestStatusError).message;
    }

    return ListView(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      children: [
        message.isNotEmpty ? ProxyTextWidget(text: message) : SizedBox.shrink(),
        Header(text: "Offered by:"),
        state.offeredByUsersList.isEmpty ? ProxyTextWidget(text: "No users found") : SizedBox.shrink(),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: state.offeredByUsersList.length,
          itemBuilder: (context, index) {
            BookOfferLocal offer = state.offeredByUsersList[index];
            return _getOfferedByListItem(offer, context);
          },
        ),
      ],
    );
  }

  Widget _getWantedByListItem(UserLocal userThatWantsBook) {
    return ListCardWidget(
      child: Column(
        children: [
          UserListCardWidget(user: userThatWantsBook),
        ],
      ),
    );
  }

  Widget _getOfferedByListItem(BookOfferLocal offer, BuildContext context) {
    return ListCardWidget(
      child: Column(
        children: [
          UserListCardWidget(user: offer.owner),
          ProxySpacingVerticalWidget(),
          ProxyButtonWidget(
            text: "Request",
            color: ThemeColors.blue,
            padding: StaticStyles.listViewPadding,
            onPressed: () {
              BlocGetter.getBookOfferBloc(context).add(
                BookOfferRequestBookEvent(offer: offer, context: context),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _getWantBtn(BookWantState state, BuildContext context) {
    return ListTile(
      leading: ProxyTextWidget(
        text: "Wanted:",
      ),
      trailing: InkWell(
        onTap: () {
          if (state.addedToWishList) {
            BlocGetter.getBookWantBloc(context).add(
              BookWantRemoveFromWantedEvent(
                bookId: bookLocal.id,
                context: context,
              ),
            );
          } else {
            BlocGetter.getBookWantBloc(context).add(
              BookWantAddToWantedEvent(
                bookId: bookLocal.id,
                context: context,
              ),
            );
          }
        },
        child: Icon(
          state.addedToWishList ? Icons.favorite : Icons.favorite_border_outlined,
        ),
      ),
    );
  }

  Widget _getOfferBtn(BookOfferState state, BuildContext context) {
    String text = "Offer book:";

    return ListTile(
      leading: ProxyTextWidget(
        text: text,
      ),
      trailing: InkWell(
        onTap: () {
          if (state.addedToOfferList) {
            BlocGetter.getBookOfferBloc(context).add(
              BookOfferRemoveFromOfferedEvent(
                bookId: bookLocal.id,
                context: context,
              ),
            );
          } else {
            BlocGetter.getBookOfferBloc(context).add(
              BookOfferAddToOfferedEvent(
                bookId: bookLocal.id,
                context: context,
              ),
            );
          }
        },
        child: Icon(
          state.addedToOfferList ? Icons.check_box_outlined : Icons.check_box_outline_blank,
        ),
      ),
    );
  }
}
