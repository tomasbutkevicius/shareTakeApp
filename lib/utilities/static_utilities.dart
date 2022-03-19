import 'package:easy_localization/easy_localization.dart';

class StaticUtilities {
  static bool isStringNumeric(String s) {
    return double. tryParse(s) != null;
  }

  static bool validISBN(String s) {
    if(!isStringNumeric(s)){
      return false;
    }
    int isbn;
    try {
      isbn = int.parse(s);
    } catch(e){
      return false;
    }

    if(isbn < 0) {
      return false;
    }
    return true;
  }

  static String formatDate(DateTime date) {
    DateFormat formatter = DateFormat('yyyy/MM/dd');

    return formatter.format(date);
  }
}