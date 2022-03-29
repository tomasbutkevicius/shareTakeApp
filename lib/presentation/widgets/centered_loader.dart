import 'package:flutter/material.dart';
import 'package:share_take/constants/theme/theme_colors.dart';
import 'package:share_take/presentation/widgets/reftesh_btn.dart';

class CenteredLoader extends StatelessWidget {
  final bool isLoading;
  final Widget? child;
  final VoidCallback? onRefresh;
  final bool showRefresh;
  

  const CenteredLoader({Key? key, required this.isLoading, this.showRefresh = false, this.child, this.onRefresh})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget errorWidget = Container(child: child ?? SizedBox.shrink(),);

    if (showRefresh) {
      return onRefresh == null ? errorWidget : Center(
        child: RefreshButton(onPressed: onRefresh!,),
      );
    }

    if (isLoading) {
      return Container(
        child: const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              ThemeColors.blue,
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