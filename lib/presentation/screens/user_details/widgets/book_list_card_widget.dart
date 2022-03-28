import 'package:flutter/material.dart';
import 'package:share_take/data/models/book/book_local.dart';
import 'package:share_take/presentation/router/static_navigator.dart';
import 'package:share_take/presentation/widgets/utilities/static_widgets.dart';

class BookListCardWidget extends StatelessWidget {
  const BookListCardWidget({Key? key, required this.book,}) : super(key: key);

  final BookLocal book;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        StaticNavigator.pushBookDetailScreen(context, book);
      },
      child: ListTile(
        leading: StaticWidgets.getIconRemote(path: book.imageUrl ?? ""),
        title: Text(book.title),
      ),
    );
  }
}