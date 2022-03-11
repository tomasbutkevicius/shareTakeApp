import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_take/bloc/book/book_bloc.dart';
import 'package:share_take/bloc/helpers/bloc_getter.dart';
import 'package:share_take/bloc/helpers/request_status.dart';
import 'package:share_take/constants/enums.dart';
import 'package:share_take/constants/settings.dart';
import 'package:share_take/constants/static_styles.dart';
import 'package:share_take/presentation/widgets/centered_loader.dart';
import 'package:share_take/presentation/widgets/proxy/spacing/proxy_spacing_widget.dart';
import 'package:share_take/presentation/widgets/proxy/text/proxy_text_widget.dart';
import 'package:share_take/presentation/widgets/utilities/static_widgets.dart';

class BookListView extends StatelessWidget {
  const BookListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocGetter.getBookBloc(context).add(BookGetListEvent());

    return BlocConsumer<BookBloc, BookState>(
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

  Widget _body(BookState state) {
    return Center(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: state.bookList.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              ProxyTextWidget(
                text: state.bookList[index].title,
                fontSize: ProxyFontSize.large,
              ),
              Container(
                constraints: BoxConstraints(maxHeight: 400, maxWidth: 400),
                child: StaticWidgets.getIconRemote(
                  path: state.bookList[index].imageUrl ?? "",
                ),
              ),
              ProxySpacingVerticalWidget(),
              Padding(
                padding: StaticStyles.listViewPadding,
                child: ProxyTextWidget(
                  text: state.bookList[index].description,
                  fontSize: ProxyFontSize.large,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
