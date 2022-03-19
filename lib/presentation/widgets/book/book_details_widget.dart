import 'package:flutter/material.dart';
import 'package:share_take/constants/enums.dart';
import 'package:share_take/data/models/book/book_local.dart';
import 'package:share_take/presentation/widgets/proxy/spacing/proxy_spacing_widget.dart';
import 'package:share_take/presentation/widgets/proxy/text/proxy_text_widget.dart';
import 'package:share_take/presentation/widgets/utilities/static_widgets.dart';
import 'package:share_take/utilities/static_utilities.dart';

class BookDetailsWidget extends StatelessWidget {
  const BookDetailsWidget({Key? key, required this.bookLocal}) : super(key: key);
  final BookLocal bookLocal;

  @override
  Widget build(BuildContext context) {
    return _body(bookLocal);
  }

  Widget _body(BookLocal book) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.brown.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                leading: ProxyTextWidget(text: book.title, fontSize: ProxyFontSize.extraLarge,),
              ),
              ListTile(
                leading: ProxyTextWidget(text: book.subtitle ?? "", fontSize: ProxyFontSize.large,),
              ),
              _getImage(book),
              ProxySpacingVerticalWidget(),
              book.publishDate != null
                  ? ListTile(
                      leading: ProxyTextWidget(
                        text: "Published:",
                        fontWeight: ProxyFontWeight.bold,

                      ),
                      trailing: ProxyTextWidget(
                        text: StaticUtilities.formatDate(book.publishDate!),
                      ),
                    )
                  : SizedBox.shrink(),
              ListTile(
                leading: ProxyTextWidget(
                  text: "Pages:",
                  fontWeight: ProxyFontWeight.bold,

                ),
                trailing: ProxyTextWidget(
                  text: book.pages.toString(),
                ),
              ),
              ListTile(
                leading: ProxyTextWidget(
                  text: "Language:",
                  fontWeight: ProxyFontWeight.bold,

                ),
                trailing: ProxyTextWidget(
                  text: book.language ?? "not specified",
                ),
              ),
              ProxySpacingVerticalWidget(),
              ListTile(
                leading: ProxyTextWidget(
                  text: "Authors:",
                  fontWeight: ProxyFontWeight.bold,
                ),
                subtitle: ListView.builder(
                    shrinkWrap: true,
                    itemCount: bookLocal.authors.length,
                    itemBuilder: (context, index) {
                      return ProxyTextWidget(text: bookLocal.authors[index]);
                    }),
              ),
              ProxySpacingVerticalWidget(),
              ListTile(
                title: ProxyTextWidget(
                  text: "Description:",
                  fontWeight: ProxyFontWeight.bold,
                ),
                subtitle: ProxyTextWidget(text: book.description),
              ),
              ProxySpacingVerticalWidget(),
              ListTile(
                leading: ProxyTextWidget(
                  text: "ISBN:",
                  fontWeight: ProxyFontWeight.bold,

                ),
                trailing: ProxyTextWidget(
                  text: book.isbn ?? "not given",
                ),
              ),
            ],
          ),
        ));
  }

  Container _getImage(BookLocal book) {
    return Container(
      constraints: BoxConstraints(maxHeight: 400, maxWidth: 400),
      child: StaticWidgets.getIconRemote(
        path: book.imageUrl ?? "",
      ),
    );
  }

  Container _getSubtitle(BookLocal book) {
    return Container(
      constraints: BoxConstraints(maxHeight: 400, maxWidth: 400),
      child: StaticWidgets.getIconRemote(
        path: book.imageUrl ?? "",
      ),
    );
  }
}
