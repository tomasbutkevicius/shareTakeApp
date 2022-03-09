import 'package:share_take/constants/enums.dart';

class StaticPaths {
  static const String translations = "assets/translations";

  static const String logoPath = "assets/images/logo.svg";



  static const Map<IconName, String> iconNameMap = {
    IconName.logo: logoPath
  };

  static String getIconPath(IconName value) => iconNameMap[value]!;
}