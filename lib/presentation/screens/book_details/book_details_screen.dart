import 'package:flutter/material.dart';
import 'package:share_take/constants/enums.dart';
import 'package:share_take/constants/static_styles.dart';
import 'package:share_take/constants/theme/theme_colors.dart';
import 'package:share_take/data/models/book/book_local.dart';
import 'package:share_take/presentation/widgets/book/book_details_widget.dart';
import 'package:share_take/presentation/widgets/custom_app_bar.dart';
import 'package:share_take/presentation/widgets/proxy/spacing/proxy_spacing_widget.dart';

class BookDetailsScreen extends StatelessWidget {
  const BookDetailsScreen({Key? key, required this.bookLocal,}) : super(key: key);
  static const String routeName = "/book";

  final BookLocal bookLocal;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBar.build(context, backgroundColor: ThemeColors.bordo.shade600),
      body: Center(
        child: ListView(
          padding: StaticStyles.listViewPadding,
          children: <Widget>[
            ProxySpacingVerticalWidget(),
            BookDetailsWidget(bookLocal: bookLocal),
            ProxySpacingVerticalWidget(size: ProxySpacing.large,),
          ],
        ),
      ),
    );
  }

}
