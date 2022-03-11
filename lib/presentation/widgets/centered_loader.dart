import 'package:flutter/material.dart';
import 'package:share_take/constants/theme/theme_colors.dart';

class CenteredLoader extends StatelessWidget {
  final bool isLoading;
  final Widget? child;

  const CenteredLoader({Key? key, required this.isLoading, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Container(
        child: const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              ThemeColors.orange,
            ),
          ),
        ),
        color: Colors.white,
      );
    } else if (child != null) {
      return Container(child: child);
    }

    return Container();
  }
}