import 'package:flutter/material.dart';
import 'package:share_take/constants/static_styles.dart';
import 'package:share_take/constants/theme/theme_colors.dart';
import 'package:share_take/data/models/book/book_local.dart';
import 'package:share_take/presentation/widgets/proxy/text/proxy_text_widget.dart';
import 'package:share_take/presentation/widgets/utilities/static_widgets.dart';

class BookDetailsWidget extends StatelessWidget {
  const BookDetailsWidget({Key? key, required this.bookLocal}) : super(key: key);
  final BookLocal bookLocal;

  @override
  Widget build(BuildContext context) {
    return _body(bookLocal);
  }
  
  Widget _body(BookLocal book) {
    return  Container(
      decoration: BoxDecoration(
        color: ThemeColors.bordo.shade600,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10)
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: StaticStyles.listViewPadding,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ProxyTextWidget(
                      text: book.title),
                  IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_forward_ios),),
                ],
              ),
              ProxyTextWidget(
                text: book.subtitle ?? "",
              ),
              Container(
                constraints: BoxConstraints(maxHeight: 250, maxWidth: 250),
                child: StaticWidgets.getIconRemote(
                  path: book.imageUrl ?? "",
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(onPressed: (){}, icon: const Icon(Icons.favorite_border_outlined),),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
