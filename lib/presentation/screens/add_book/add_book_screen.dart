import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_take/bloc/book_add/book_add_bloc.dart';
import 'package:share_take/bloc/helpers/bloc_getter.dart';
import 'package:share_take/bloc/helpers/request_status.dart';
import 'package:share_take/constants/static_styles.dart';
import 'package:share_take/constants/theme/theme_colors.dart';
import 'package:share_take/data/repositories/book_repository.dart';
import 'package:share_take/presentation/screens/add_book/widgets/add_book_form.dart';
import 'package:share_take/presentation/widgets/custom_app_bar.dart';
import 'package:share_take/presentation/widgets/header.dart';
import 'package:share_take/presentation/widgets/information_card.dart';
import 'package:share_take/presentation/widgets/proxy/spacing/proxy_spacing_widget.dart';
import 'package:share_take/presentation/widgets/utilities/static_widgets.dart';

class AddBookScreen extends StatelessWidget {
  const AddBookScreen({Key? key}) : super(key: key);
  static const String routeName = "/books/add";

  @override
  Widget build(BuildContext context) {
    String message = "";

    return Scaffold(
      appBar: CustomAppBar.build(context, backgroundColor: ThemeColors.bordo.shade600),
      body: BlocProvider(
        create: (context) => BookAddBloc(bookRepository: context.read<BookRepository>()),
        child: BlocBuilder<BookAddBloc, BookAddState>(
          builder: (context, state) {
            if (state.status is RequestStatusError) {
              RequestStatusError status = state.status as RequestStatusError;
              message = status.message;
              // StaticWidgets.showSnackBar(context, message);
            } else if(state.status is RequestStatusSuccess){
              RequestStatusSuccess status = state.status as RequestStatusSuccess;
              message = status.message;
            } else {
              message = "";
            }

            if (state.status is RequestStatusLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    message.isEmpty
                        ? SizedBox.shrink()
                        : Padding(
                            padding: StaticStyles.contentPadding,
                            child: InkWell(
                              onTap: () {
                                BlocGetter.getAddBookBloc(context).add(BookAddStatusResetEvent());
                              },
                              child: InformationCard(
                                message: message,
                                backgroundColor: ThemeColors.bordo.shade500,
                                textColor: ThemeColors.white,
                              ),
                            ),
                          ),
                    Header(text: "Add book"),
                    ProxySpacingVerticalWidget(),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: 480.0,
                      ),
                      child: AddBookForm(bookToAdd: state.bookToAdd),
                    ),
                    ProxySpacingVerticalWidget(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
