import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_take/bloc/book_list/book_list_bloc.dart';
import 'package:share_take/bloc/helpers/bloc_getter.dart';
import 'package:share_take/bloc/helpers/request_status.dart';
import 'package:share_take/constants/enums.dart';
import 'package:share_take/constants/static_styles.dart';
import 'package:share_take/constants/theme/theme_colors.dart';
import 'package:share_take/data/models/book/book_local.dart';
import 'package:share_take/presentation/widgets/centered_loader.dart';
import 'package:share_take/presentation/widgets/proxy/spacing/proxy_spacing_widget.dart';
import 'package:share_take/presentation/widgets/proxy/text/proxy_text_widget.dart';
import 'package:share_take/presentation/widgets/utilities/static_widgets.dart';

class BookListView extends StatelessWidget {
  const BookListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocGetter.getBookListBloc(context).add(BookListGetListEvent());

    return BlocConsumer<BookListBloc, BookListState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return CenteredLoader(
          isLoading: state.status is RequestStatusLoading,
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
                      _bookCard(state.bookList[index]),
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

  Widget _bookCard(BookLocal book) {
    return  Container(
      decoration: BoxDecoration(
        color: ThemeColors.bordo.shade600,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10)
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: StaticStyles.listViewPadding,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ProxyTextWidget(
                      text: book.title),
                  IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_forward_ios),),
                ],
              ),
              ProxyTextWidget(
                text: book.subtitle ?? "",
              ),
              Container(
                constraints: BoxConstraints(maxHeight: 250, maxWidth: 250),
                child: StaticWidgets.getIconRemote(
                  path: book.imageUrl ?? "",
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(onPressed: (){}, icon: const Icon(Icons.favorite_border_outlined),),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
