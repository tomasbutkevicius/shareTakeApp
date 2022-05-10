import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_take/bloc/book_list/book_list_bloc.dart';
import 'package:share_take/bloc/helpers/bloc_getter.dart';
import 'package:share_take/bloc/helpers/request_status.dart';
import 'package:share_take/constants/static_styles.dart';
import 'package:share_take/constants/theme/theme_colors.dart';
import 'package:share_take/data/models/book/book_local.dart';
import 'package:share_take/presentation/router/static_navigator.dart';
import 'package:share_take/presentation/widgets/centered_loader.dart';
import 'package:share_take/presentation/widgets/list_card.dart';
import 'package:share_take/presentation/widgets/proxy/spacing/proxy_spacing_widget.dart';
import 'package:share_take/presentation/widgets/proxy/text/proxy_text_widget.dart';
import 'package:share_take/presentation/widgets/utilities/static_widgets.dart';

class BookListView extends StatelessWidget {
  const BookListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocGetter.getBookListBloc(context).add(BookListGetListEvent());

    return BlocBuilder<BookListBloc, BookListState>(
      builder: (context, state) {
        return CenteredLoader(
          isLoading: state.status is RequestStatusLoading,
          showRefresh: state.status is RequestStatusError,
          onRefresh: (){
            BlocGetter.getBookListBloc(context).add(BookListResetEvent());
            BlocGetter.getBookListBloc(context).add(BookListGetListEvent());
          },
          child: _body(state),
        );
      },
    );
  }

  Widget _body(BookListState state) {
    return Center(
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: state.bookList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: StaticStyles.listViewPadding,
                  child: Column(
                    children: [
                      ProxySpacingVerticalWidget(),
                      _bookCard(state.bookList[index], context),
                      ProxySpacingVerticalWidget(),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _bookCard(BookLocal book, BuildContext context) {
    return ListCardWidget(
      child: Padding(
        padding: StaticStyles.listViewPadding,
        child: Column(
          children: [
            Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: ProxyTextWidget(text: book.title),
                ),
                Expanded(
                  child: IconButton(
                    onPressed: () {
                      StaticNavigator.pushBookDetailScreen(context, book);
                    },
                    icon: const Icon(Icons.arrow_forward_ios),
                  ),
                ),
              ],
            ),
            ProxyTextWidget(
              text: book.subtitle ?? "",
            ),
            Container(
              constraints: BoxConstraints(
                minHeight: 250,
                minWidth: 250,
                maxHeight: 250,
                maxWidth: 250,
              ),
              child: StaticWidgets.getIconRemote(
                path: book.imageUrl ?? "",
              ),
            ),
            Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  flex: 2,
                  child: ProxySpacingVerticalWidget(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
