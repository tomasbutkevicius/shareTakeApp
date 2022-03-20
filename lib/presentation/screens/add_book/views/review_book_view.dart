import 'package:flutter/material.dart';
import 'package:share_take/bloc/book_add/book_add_bloc.dart';
import 'package:share_take/bloc/helpers/bloc_getter.dart';
import 'package:share_take/constants/enums.dart';
import 'package:share_take/constants/static_styles.dart';
import 'package:share_take/constants/theme/theme_colors.dart';
import 'package:share_take/data/models/book/book_local.dart';
import 'package:share_take/presentation/widgets/book/book_details_widget.dart';
import 'package:share_take/presentation/widgets/header.dart';
import 'package:share_take/presentation/widgets/information_card.dart';
import 'package:share_take/presentation/widgets/proxy/button/proxy_button_widget.dart';
import 'package:share_take/presentation/widgets/proxy/spacing/proxy_spacing_widget.dart';

class ReviewBookView extends StatelessWidget {
  const ReviewBookView({Key? key, required this.message, required this.bookLocal}) : super(key: key);
  final String message;
  final BookLocal bookLocal;

  @override
  Widget build(BuildContext context) {
    return _buildReviewBookScreen(message, context, bookLocal);
  }

  Widget _buildReviewBookScreen(String message, BuildContext context, BookLocal bookLocal) {
    return Scaffold(
      body: Center(
        child: ListView(
          padding: StaticStyles.listViewPadding,
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
            ProxySpacingVerticalWidget(size: ProxySpacing.large,),
            _getSubmitBtn(context),
          ProxySpacingVerticalWidget(size: ProxySpacing.large,),
            _getStageToEditBtn(context),
            ProxySpacingVerticalWidget(),
          ],
        ),
      ),
    );
  }

  Widget _getSubmitBtn(BuildContext context) {
    String buttonText = "Submit";
    return ProxyButtonWidget(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 100,
      ),
      text: buttonText,
      color: ThemeColors.blue.shade600,
      isUppercase: false,
      onPressed: () {
        BlocGetter.getAddBookBloc(context).add(BookAddSubmitEvent(bookLocal: bookLocal),);
      },
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
