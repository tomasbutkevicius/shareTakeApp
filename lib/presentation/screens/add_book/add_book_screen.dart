import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_take/bloc/authentication/authentication_bloc.dart';
import 'package:share_take/bloc/book_add/book_add_bloc.dart';
import 'package:share_take/bloc/helpers/bloc_getter.dart';
import 'package:share_take/bloc/helpers/request_status.dart';
import 'package:share_take/constants/static_styles.dart';
import 'package:share_take/constants/theme/theme_colors.dart';
import 'package:share_take/data/models/book/book_local.dart';
import 'package:share_take/data/repositories/book_repository.dart';
import 'package:share_take/presentation/screens/add_book/views/edit_book_view.dart';
import 'package:share_take/presentation/screens/add_book/views/review_book_view.dart';
import 'package:share_take/presentation/screens/add_book/widgets/add_book_form.dart';
import 'package:share_take/presentation/widgets/book/book_details_main_widget.dart';
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
      create: (context) => BookAddBloc(
        authenticationBloc: context.read<AuthenticationBloc>(),
          bookRepository: context.read<BookRepository>()),
      child: BlocBuilder<BookAddBloc, BookAddState>(
        builder: (context, state) {
          if (state.status is RequestStatusError) {
            RequestStatusError status = state.status as RequestStatusError;
            message = status.message;
            // StaticWidgets.showSnackBar(context, message);
          } else if (state.status is RequestStatusSuccess) {
            RequestStatusSuccess status = state.status as RequestStatusSuccess;
            message = status.message;
          } else {
            message = "";
          }

          if (state.status is RequestStatusLoading) {
            return _buildLoadingScreen(context);
          }

          if (state.stage is BookAddEditStage) {
            return EditBookView(
              bookAddState: state,
              message: message,
            );
          }

          if (state.stage is BookAddReviewStage) {
            return ReviewBookView(
              message: message,
              bookLocal: state.bookToAdd,
            );
          }

          return _buildLoadingScreen(context);
        },
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
}
