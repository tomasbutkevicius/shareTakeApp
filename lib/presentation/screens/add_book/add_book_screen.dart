import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_take/bloc/book_add/book_add_bloc.dart';
import 'package:share_take/bloc/helpers/bloc_getter.dart';
import 'package:share_take/bloc/helpers/request_status.dart';
import 'package:share_take/constants/static_styles.dart';
import 'package:share_take/constants/theme/theme_colors.dart';
import 'package:share_take/data/models/book/book_local.dart';
import 'package:share_take/data/repositories/book_repository.dart';
import 'package:share_take/presentation/screens/add_book/widgets/add_book_form.dart';
import 'package:share_take/presentation/widgets/book/book_details_widget.dart';
import 'package:share_take/presentation/widgets/custom_app_bar.dart';
import 'package:share_take/presentation/widgets/header.dart';
import 'package:share_take/presentation/widgets/information_card.dart';
import 'package:share_take/presentation/widgets/proxy/button/proxy_button_widget.dart';
import 'package:share_take/presentation/widgets/proxy/spacing/proxy_spacing_widget.dart';

class AddBookScreen extends StatelessWidget {
  const AddBookScreen({Key? key}) : super(key: key);
  static const String routeName = "/books/add";

  @override
  Widget build(BuildContext context) {
    String message = "";

    return BlocProvider(
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
              return _buildLoadingScreen(context);
            }

            if(state.stage is BookAddEditStage){
              return _buildEditBookScreen(message, context, state);
            }

            if(state.stage is BookAddReviewStage){
              BookAddReviewStage stage = state.stage as BookAddReviewStage;
              return _buildReviewBookScreen(message, context, state.bookToAdd);
            }

            return _buildLoadingScreen(context);

          },
        ),
      );
  }

  Widget _buildEditBookScreen(String message, BuildContext context, BookAddState state) {
    return Scaffold(
      appBar: CustomAppBar.build(context, backgroundColor: ThemeColors.bordo.shade600),
      body: Center(
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
                                backgroundColor: ThemeColors.bordo.shade400,
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
            ),
    );
  }

  Widget _buildLoadingScreen(BuildContext context) {
    return Scaffold(
                appBar: CustomAppBar.build(context, backgroundColor: ThemeColors.bordo.shade600),
                body: const Center(
                child: CircularProgressIndicator(),
              ),
            );
  }

  Widget _buildReviewBookScreen(String message, BuildContext context, BookLocal bookLocal) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: StaticStyles.listViewPadding,
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
                Header(text: "Review book submission"),
                ProxySpacingVerticalWidget(),
                BookDetailsWidget(bookLocal: bookLocal),
                ProxySpacingVerticalWidget(),
                _getStageToEditBtn(context),
                ProxySpacingVerticalWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getStageToEditBtn(BuildContext context) {
    String buttonText = "Back to Edit";
    return ProxyButtonWidget(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 100,
      ),
      text: buttonText,
      color: ThemeColors.bordo.shade600,
      isUppercase: false,
      onPressed: () {
        BlocGetter.getAddBookBloc(context).add(BookAddEditStageEvent());
      },
    );
  }
}
