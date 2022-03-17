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
}