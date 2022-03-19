import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_take/bloc/book_add/book_add_bloc.dart';
import 'package:share_take/bloc/helpers/bloc_getter.dart';
import 'package:share_take/constants/enums.dart';
import 'package:share_take/constants/static_styles.dart';
import 'package:share_take/constants/theme/theme_colors.dart';
import 'package:share_take/data/models/book/book_local.dart';
import 'package:share_take/presentation/widgets/proxy/button/proxy_button_widget.dart';
import 'package:share_take/presentation/widgets/proxy/input/proxy_text_form_field.dart';
import 'package:share_take/presentation/widgets/proxy/spacing/proxy_spacing_widget.dart';

class AddBookForm extends StatefulWidget {
  const AddBookForm({Key? key, required this.bookToAdd}) : super(key: key);

  final BookLocal bookToAdd;

  @override
  _AddBookFormState createState() => _AddBookFormState();
}

class _AddBookFormState extends State<AddBookForm> {
  late final TextEditingController _isbnController = TextEditingController(text: widget.bookToAdd.isbn);
  late final TextEditingController _titleController = TextEditingController(text: widget.bookToAdd.title);
  late final TextEditingController _subtitleController = TextEditingController(text: widget.bookToAdd.subtitle);
  late final TextEditingController _authorsController = TextEditingController(text: widget.bookToAdd.authors.toString());
  late final TextEditingController _imageController = TextEditingController(text: widget.bookToAdd.imageUrl);
  late final TextEditingController _langController = TextEditingController(text: widget.bookToAdd.language);
  late final TextEditingController _pagesController = TextEditingController(text: widget.bookToAdd.pages.toString());
  late final TextEditingController _dateController = TextEditingController(text: "");

  late DateTime selectedDate;
  late final TextEditingController _descriptionController = TextEditingController(text: widget.bookToAdd.description);

  final focus = FocusNode();

  @override
  void initState() {
    DateFormat formatter = DateFormat('yyyy/MM/dd');

    selectedDate = widget.bookToAdd.publishDate ?? DateTime.now();
    _dateController.value = TextEditingValue(text: formatter.format(selectedDate));
    super.initState();

  }

  @override
  void dispose() {
    _isbnController.dispose();
    // _authorsController.dispose();
    _titleController.dispose();
    _subtitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _authorsController.text = widget.bookToAdd.authors.toString();
    return Form(
          child: Padding(
            padding: StaticStyles.listViewPadding,
            child: Column(
              children: <Widget>[
                _getScanBtn(context),
                const ProxySpacingVerticalWidget(
                  size: ProxySpacing.extraLarge,
                ),
                _inputField(context: context, controller: _isbnController, label: "isbn", enabled: false),
                _getISBNPickerBtn(context),
                const ProxySpacingVerticalWidget(),
                _inputField(
                  context: context,
                  controller: _titleController,
                  label: "Title",
                ),
                const ProxySpacingVerticalWidget(),
                _inputField(context: context, controller: _subtitleController, label: "Subtitle"),
                const ProxySpacingVerticalWidget(),
                _inputField(context: context, controller: _authorsController, label: "Authors", enabled: false),
                const ProxySpacingVerticalWidget(),
                _getAddAuthorBtn(context),
                const ProxySpacingVerticalWidget(),
                _getRemoveAuthorBtn(context),
                const ProxySpacingVerticalWidget(),
                _inputField(context: context, controller: _imageController, label: "Image url", enabled: false),
                const ProxySpacingVerticalWidget(),
                _inputField(
                  context: context,
                  controller: _langController,
                  label: "Language",
                ),
                const ProxySpacingVerticalWidget(),
                _inputField(
                  context: context,
                  controller: _pagesController,
                  label: "Pages",
                  textInputType: TextInputType.number,
                ),
                const ProxySpacingVerticalWidget(),
                _inputField(
                  context: context,
                  controller: _dateController,
                  label: "Publish date",
                  textInputType: TextInputType.datetime,
                  enabled: false,
                ),
                const ProxySpacingVerticalWidget(),
                // _getDatePickerBtn(context),
                const ProxySpacingVerticalWidget(),
                _inputField(context: context, controller: _descriptionController, label: "description"),
                const ProxySpacingVerticalWidget(
                  size: ProxySpacing.extraLarge,
                ),
                _getReviewBtn(context)
              ],
            ),
          ),
        );
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Cancel', true, ScanMode.BARCODE);

      BlocGetter.getAddBookBloc(context).add(BookAddHandleIsbnEvent(isbn: barcodeScanRes));
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
  }

  Widget _inputField({
    required BuildContext context,
    required TextEditingController controller,
    required String label,
    TextInputType textInputType = TextInputType.text,
    bool enabled = true,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 480,
            ),
            child: ProxyTextFormField(
              enabled: enabled,
              controller: controller,
              textInputAction: TextInputAction.next,
              keyboardType: textInputType,
              onFieldSubmitted: (v) {
                FocusScope.of(context).requestFocus(focus);
              },
              labelText: label,
              icon: Icon(
                Icons.description,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _getScanBtn(BuildContext context) {
    String buttonText = "Scan";
    return ProxyButtonWidget(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 100,
      ),
      text: buttonText,
      color: ThemeColors.bordo.shade600,
      isUppercase: false,
      onPressed: () async {
        await scanBarcodeNormal();
      },
    );
  }

  Widget _getISBNPickerBtn(BuildContext context) {
    String buttonText = "Enter ISBN";
    return ProxyButtonWidget(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 100,
      ),
      text: buttonText,
      color: ThemeColors.bordo.shade600,
      isUppercase: false,
      onPressed: () async {
        await _displayISBNInputDialog(context);
      },
    );
  }

  Widget _getAddAuthorBtn(BuildContext context) {
    String buttonText = "Add author";
    return ProxyButtonWidget(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 100,
      ),
      text: buttonText,
      color: ThemeColors.bordo.shade600,
      isUppercase: false,
      onPressed: () async {
        await _displayAuthorInputDialog(context);
      },
    );
  }

  Widget _getRemoveAuthorBtn(BuildContext context) {
    String buttonText = "Remove author";
    return ProxyButtonWidget(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 100,
      ),
      text: buttonText,
      color: ThemeColors.bordo.shade600,
      isUppercase: false,
      onPressed: () {
        if (widget.bookToAdd.authors.isNotEmpty) {
          setState(() {
            widget.bookToAdd.authors.removeLast();
            _authorsController.text = widget.bookToAdd.authors.toString();
          });
        }
      },
    );
  }

  Widget _getDatePickerBtn(BuildContext context) {
    String buttonText = "Select date";
    return ProxyButtonWidget(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 100,
      ),
      text: buttonText,
      color: ThemeColors.bordo.shade600,
      isUppercase: false,
      onPressed: () async {
        await _selectDate(context);
      },
    );
  }

  Future _selectDate(BuildContext context) async {
    DateFormat formatter = DateFormat('yyyy/MM/dd');

    final DateTime? picked =
    await showDatePicker(context: context, initialDate: selectedDate, firstDate: DateTime(1901, 1), lastDate: DateTime(2100));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        _dateController.value = TextEditingValue(text: formatter.format(picked));
      });
  }

  Widget _getReviewBtn(BuildContext context) {
    String buttonText = "Review";
    return ProxyButtonWidget(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 100,
      ),
      text: buttonText,
      color: ThemeColors.bordo.shade600,
      isUppercase: false,
      onPressed: () {
        BookLocal bookLocal = BookLocal(
          id: widget.bookToAdd.id,
          title: _titleController.text,
          authors: widget.bookToAdd.authors,
          pages: int.parse(_pagesController.text),
          publishDate: selectedDate,
          description: _descriptionController.text,
          language: _langController.text,
          imageUrl: _imageController.text,
          subtitle: _subtitleController.text,
          isbn: _isbnController.text,
        );

        BlocGetter.getAddBookBloc(context).add(
          BookAddReviewStageEvent(bookLocal: bookLocal),
        );
      },
    );
  }

  Future<void> _displayAuthorInputDialog(BuildContext context) async {
    String authorValue = "";
    return showDialog(
        context: context,
        builder: (alertContext) {
          return AlertDialog(
            title: Text('Add author'),
            content: TextField(
              onChanged: (value) {
                authorValue = value;
              },
              decoration: InputDecoration(hintText: "Type author name"),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('ok'),
                onPressed: () {
                  if (authorValue
                      .trim()
                      .isNotEmpty) {
                    BlocGetter.getAddBookBloc(context).add(
                      BookAddChangeBookDataEvent(
                        bookLocal: widget.bookToAdd.copyWith(
                          authors: [
                            ...widget.bookToAdd.authors,
                            authorValue,
                          ],
                        ),
                      ),
                    );
                    Navigator.of(alertContext).pop();
                  }
                },
              ),
            ],
          );
        });
  }

  Future<void> _displayISBNInputDialog(BuildContext context) async {
    String isbnValue = "";
    return showDialog(
        context: context,
        builder: (alertContext) {
          return AlertDialog(
            title: Text('TextField in Dialog'),
            content: TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                isbnValue = value;
              },
              decoration: InputDecoration(hintText: "Text Field in Dialog"),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('ok'),
                onPressed: () {
                  BlocGetter.getAddBookBloc(context).add(BookAddHandleIsbnEvent(isbn: isbnValue));
                  Navigator.pop(alertContext);
                },
              ),
            ],
          );
        });
  }
}
