import 'package:flutter/material.dart';
import 'package:share_take/bloc/book_add/book_add_bloc.dart';
import 'package:share_take/bloc/helpers/bloc_getter.dart';
import 'package:share_take/constants/static_styles.dart';
import 'package:share_take/constants/theme/theme_colors.dart';
import 'package:share_take/presentation/screens/add_book/widgets/add_book_form.dart';
import 'package:share_take/presentation/widgets/custom_app_bar.dart';
import 'package:share_take/presentation/widgets/header.dart';
import 'package:share_take/presentation/widgets/information_card.dart';
import 'package:share_take/presentation/widgets/proxy/spacing/proxy_spacing_widget.dart';

class EditBookView extends StatelessWidget {
  const EditBookView({Key? key, required this.message, required this.bookAddState}) : super(key: key);
  final String message;
  final BookAddState bookAddState;

  @override
  Widget build(BuildContext context) {
    return _buildEditBookScreen(message, context, bookAddState);
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
}
