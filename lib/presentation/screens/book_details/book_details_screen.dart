import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_take/bloc/book_details/book_details_bloc.dart';
import 'package:share_take/bloc/helpers/bloc_getter.dart';
import 'package:share_take/bloc/helpers/request_status.dart';
import 'package:share_take/constants/enums.dart';
import 'package:share_take/constants/static_styles.dart';
import 'package:share_take/constants/theme/theme_colors.dart';
import 'package:share_take/data/models/book/book_local.dart';
import 'package:share_take/data/models/book_wants/book_wants_remote.dart';
import 'package:share_take/presentation/widgets/book/book_details_widget.dart';
import 'package:share_take/presentation/widgets/centered_loader.dart';
import 'package:share_take/presentation/widgets/custom_app_bar.dart';
import 'package:share_take/presentation/widgets/header.dart';
import 'package:share_take/presentation/widgets/proxy/spacing/proxy_spacing_widget.dart';
import 'package:share_take/presentation/widgets/proxy/text/proxy_text_widget.dart';
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

    BlocGetter.getBookDetailsBloc(context).add(BookDetailsGetEvent(bookId: bookLocal.id));

    return Scaffold(
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
            BlocBuilder<BookDetailsBloc, BookDetailsState>(
              builder: (context, state) {
                return CenteredLoader(
                  isLoading: state is RequestStatusLoading,
                  child: _buildMoreDetails(context, state),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMoreDetails(BuildContext context, BookDetailsState state) {

    if(state.status is RequestStatusError){
      StaticWidgets.showSnackBar(context, (state.status as RequestStatusError).message);
    }

    return ListView(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      children: [
        ListTile(
          leading: ProxyTextWidget(
            text: "Mark as wanted",
          ),
          trailing: InkWell(
            onTap: () {
              if(state.addedToWishList) {
                BlocGetter.getBookDetailsBloc(context).add(
                  BookDetailsRemoveFromWantedEvent(
                    bookId: bookLocal.id,
                  ),
                );
              } else {
                BlocGetter.getBookDetailsBloc(context).add(
                  BookDetailsAddToWantedEvent(
                    bookId: bookLocal.id,
                  ),
                );
              }
            },
            child: Icon(
              state.addedToWishList ? Icons.favorite : Icons.favorite_border_outlined,
            ),
          ),
        ),
        Header(text: "Wanted by:"),
        ListView.builder(
          shrinkWrap: true,
          itemCount: state.wantedList.length,
          itemBuilder: (context, index) {
            BookWantsRemote bookWant = state.wantedList[index];
            return ListTile(
              leading: ProxyTextWidget(
                text: "User " + bookWant.userId,
              ),
            );
          },
        ),
      ],
    );
  }
}
