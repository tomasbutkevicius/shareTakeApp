import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_take/constants/api.dart';
import 'package:share_take/constants/enums.dart';
import 'package:share_take/constants/static_paths.dart';
import 'package:share_take/constants/theme/theme_colors.dart';
import 'package:share_take/data/firebase_storage.dart';

import '../../../constants/proxy.dart';

class StaticWidgets {
  static void showSnackBar(BuildContext context, String message, {TimeDuration duration = TimeDuration.short}) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: ThemeColors.orange.shade400,
      duration: StaticProxy.getTimeDurationValue(duration),
    );
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  static Future showCustomDialog({required BuildContext context, required Widget child}) async {
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      await showDialog(
        barrierColor: ThemeColors.orange.withOpacity(0.3),
        context: context,
        builder: (context) {
          return child;
        },
      );
    });
  }

  static Widget getIcon({required IconName name, double? width, double? height, Color? color}) {
    String path = StaticPaths.getIconPath(name);

    if (path.contains("png")) {
      return Image(
        image: AssetImage(
          path,
        ),
        width: width,
        height: height,
        color: color,
      );
    } else {
      return SvgPicture.asset(
        path,
        width: width,
        height: height,
        color: color,
      );
    }
  }

  static Widget getIconRemote(
      {required String path, double? width, double? height, Color? color, Widget errorWidget = const Icon(Icons.image, size: 50,)}) {
    try {
      return Image.network(
        path,
        width: width,
        height: height,
        color: color,
        errorBuilder: (context, error, trace) {
          return errorWidget;

          return SvgPicture.network(
            path,
            width: width,
            height: height,
            color: color,
          );
        },
      );
    } catch (e) {
      return errorWidget;
    }
  }
}
