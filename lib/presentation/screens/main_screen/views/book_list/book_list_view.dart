import 'package:flutter/material.dart';
import 'package:share_take/presentation/widgets/proxy/text/proxy_text_widget.dart';

class BookListView extends StatelessWidget {
  const BookListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: ProxyTextWidget(
        text: "Book list view",
      ),
    );
  }
}
