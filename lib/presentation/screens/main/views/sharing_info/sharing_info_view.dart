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
                Icon(Icons.swap_horizontal_circle_outlined),
                Container(
                  height: 50,
                  width: 250,
                  child: ProxyButtonWidget(
                    color: ThemeColors.light_blue.shade600,
                    text: "Trades",
                    padding: StaticStyles.listViewPadding,
                    onPressed: (){
                      StaticNavigator.pushTradeListScreen(context);
                    },
                  ),
                ),
              ],
            ),
            ProxySpacingVerticalWidget(
              size: ProxySpacing.huge,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.notifications_active_outlined),
                Container(
                  height: 50,
                  width: 250,
                  child: ProxyButtonWidget(
                    color: ThemeColors.orange.shade600,
                    text: "Received requests",
                    padding: StaticStyles.listViewPadding,
                    onPressed: (){
                      StaticNavigator.pushRequestsOwnerScreen(context);
                    },
                  ),
                ),
              ],
            ),
            ProxySpacingVerticalWidget(
              size: ProxySpacing.huge,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.send_to_mobile),
                Container(
                  height: 50,
                  width: 250,
                  child: ProxyButtonWidget(
                    color: ThemeColors.orange.shade600,
                    text: "My requests",
                    padding: StaticStyles.listViewPadding,
                    onPressed: (){
                      StaticNavigator.pushRequestsReceiverScreen(context);
                    },
                  ),
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
