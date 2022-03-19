import 'package:flutter/material.dart';
import 'package:share_take/constants/theme/theme_colors.dart';
import 'package:share_take/data/models/book/book_local.dart';
import 'package:share_take/presentation/widgets/book/book_details_widget.dart';
import 'package:share_take/presentation/widgets/custom_app_bar.dart';

class BookDetailsScreen extends StatelessWidget {
  const BookDetailsScreen({Key? key, required this.bookLocal,}) : super(key: key);
  static const String routeName = "/book";

  final BookLocal bookLocal;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBar.build(context, backgroundColor: ThemeColors.bordo.shade600),
      body: BookDetailsWidget(bookLocal: bookLocal,),
    );
  }

}
