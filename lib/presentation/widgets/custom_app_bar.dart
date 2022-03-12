
import 'package:flutter/material.dart';
import 'package:share_take/constants/theme/theme_colors.dart';
import 'package:share_take/presentation/widgets/title_widget.dart';

class CustomAppBar {
  static AppBar build(
      BuildContext context, {
        bool showBackBtn = true,
        bool showTitle = true,
        Color backgroundColor = const Color(0xFF764800),
      }) {
    return AppBar(
      shadowColor: ThemeColors.white.withOpacity(0.5),
      backgroundColor: backgroundColor,
      leading: showBackBtn ? _backButton(context) : SizedBox.shrink(),
      title: showTitle ? const Center(
        child: AppTitleTextWidget(),
      ) : null,
      actions: [
        Builder(
          builder: (context) {
            if (!Scaffold.of(context).hasDrawer) {
              return IconButton(
                padding: EdgeInsets.only(right: 30),
                icon: SizedBox.shrink(),
                onPressed: () {},
              );
            }
            return IconButton(
              padding: EdgeInsets.only(right: 30),
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ],
    );
  }

  static Widget _backButton(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.only(left: 30),
      icon: Icon(Icons.arrow_back),
      onPressed: () => Navigator.pop(context),
    );
  }
}