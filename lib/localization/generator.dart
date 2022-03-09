import 'dart:convert';
import 'dart:io';

void main() {
  Generator().run("assets/translations/en.json", 'lib/localization/translations.dart');
}

class Generator {
  Future run(String filePath, String writePath) async {
    final file = File(filePath);
    final String translations = file.readAsStringSync();
    parse(translations, writePath, filePath);
  }

  String replaceCharAt(String oldString, int index, String newChar) {
    return oldString.substring(0, index) + newChar + oldString.substring(index + 1);
  }

  Future<void> parse(String jsonFileString, String writePath, String readFilePath) async {
    var writeBuffer = StringBuffer();
    Map<String, dynamic> translationMapDynamic = jsonDecode(
        jsonFileString) as Map<String, dynamic>;

    Map<String, String> translationMap = translationMapDynamic.map((key,
        dynamic value) => MapEntry(key, value.toString()));

    translationMap.forEach((key, value) {
      addToWriteBuffer(key, writeBuffer);
    });

    writeTranslationsGetterClass(writeBuffer.toString(), writePath, readFilePath);
  }

  void addToWriteBuffer(String key, StringBuffer sb) {

    String methodName = key;

    for (int i = 0; i < (methodName.length - 1); i++) {
      var char = methodName[i];
      if (char == "_") {
        methodName = replaceCharAt(methodName, i + 1, methodName[i+1].toUpperCase());
      }
    }

    methodName = methodName.replaceAll("_", "");

    var entry = """
  static String get $methodName {
    return tr("$key");
  }
  """;
    sb.write(entry);
    sb.write("\n");
  }

  Future writeTranslationsGetterClass(String entries, String writePath, String readFilePath) async {
    var body = """
import 'package:easy_localization/easy_localization.dart';
//This is a generated file by generator.dart
//Generated from file $readFilePath

class Translations {
  
$entries

}
    """;

    File file = File(writePath);
    file.writeAsString(body).then((File f) {
      print('File written : ' + f.path);
    });
  }

}