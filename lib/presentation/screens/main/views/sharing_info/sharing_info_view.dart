import 'package:flutter/material.dart';
import 'package:share_take/constants/enums.dart';
import 'package:share_take/constants/static_styles.dart';
import 'package:share_take/constants/theme/theme_colors.dart';
import 'package:share_take/presentation/router/static_navigator.dart';
import 'package:share_take/presentation/widgets/list_card.dart';
import 'package:share_take/presentation/widgets/proxy/button/proxy_button_widget.dart';
import 'package:share_take/presentation/widgets/proxy/spacing/proxy_spacing_widget.dart';

class SharingInfoView extends StatelessWidget {
  const SharingInfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: StaticStyles.listViewPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ProxySpacingVerticalWidget(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.file_upload),
                ProxyButtonWidget(
                  color: ThemeColors.blue.shade600,
                  text: "Book Requests (as owner)",
                  padding: StaticStyles.listViewPadding,
                ),
              ],
            ),
            ProxySpacingVerticalWidget(
              size: ProxySpacing.huge,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.file_download),
                ProxyButtonWidget(
                  color: ThemeColors.blue.shade600,
                  text: "Book Requests (as receiver)",
                  padding: StaticStyles.listViewPadding,
                  onPressed: (){
                    StaticNavigator.pushRequestsReceiverScreen(context);
                  },
                ),
              ],
            ),
            ProxySpacingVerticalWidget(),
          ],
        ),
      ),
    );
  }
}
