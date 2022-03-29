import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/src/provider.dart';
import 'package:share_take/bloc/authentication/authentication_bloc.dart';
import 'package:share_take/bloc/helpers/bloc_getter.dart';
import 'package:share_take/bloc/helpers/request_status.dart';
import 'package:share_take/constants/enums.dart';
import 'package:share_take/constants/static_styles.dart';
import 'package:share_take/constants/theme/theme_colors.dart';
import 'package:share_take/localization/translations.dart';
import 'package:share_take/presentation/widgets/proxy/spacing/proxy_spacing_widget.dart';
import 'package:share_take/presentation/widgets/proxy/text/proxy_text_widget.dart';

import '../router/static_navigator.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const padding = EdgeInsets.symmetric(horizontal: 5);

    return Drawer(
      child: Material(
        color: ThemeColors.blue,
        child: ListView(
          padding: padding,
          children: [
            const ProxySpacingVerticalWidget(
              size: ProxySpacing.extraLarge,
            ),
            BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                bool isLoggedIn = state.user != null;
                if(isLoggedIn) {
                  return _buildMenuItemIconData(
                    text: state.user!.email,
                    iconData: Icons.verified_user,
                    onTap: () {
                      StaticNavigator.popContext(context);
                      StaticNavigator.pushUserScreen(context);
                    },
                  );
                }
                return _buildMenuItemIconData(
                  text: "Not logged in",
                  iconData: Icons.supervised_user_circle_sharp,
                  onTap: () {

                  },
                );
              },
            ),
            _buildDivider(),
            _buildMenuItemIconData(
              text: Translations.wishList,
              iconData: Icons.favorite,
              onTap: () {
                Navigator.pop(context);
                // StaticNavigator.navigateToTemperatureMain(context);
              },
            ),
            _buildMenuItemIconData(
              text: Translations.yourOffers,
              iconData: Icons.folder_shared,
              onTap: () {
                Navigator.pop(context);
                // StaticNavigator.navigateToHistoryMain(context);
              },
            ),
            _buildMenuItemIconData(
              text: "Add book",
              iconData: Icons.add,
              onTap: () {
                Navigator.pop(context);
                StaticNavigator.pushAddBookScreen(context);
              },
            ),
            const ProxySpacingVerticalWidget(
              size: ProxySpacing.small,
            ),
            _buildDivider(),
            const ProxySpacingVerticalWidget(
              size: ProxySpacing.small,
            ),
            BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                bool isLoggedIn = state.user != null;

                if(state.status is RequestStatusLoading){
                  return const Center(child: CircularProgressIndicator());
                }

                return _buildMenuItemIconData(
                  text: isLoggedIn ? Translations.logout : Translations.login,
                  iconData: isLoggedIn ? Icons.logout : Icons.login,
                  onTap: () {
                    if (isLoggedIn) {
                      context.read<AuthenticationBloc>().add(AuthLoggedOutEvent());
                      StaticNavigator.popContext(context);
                      StaticNavigator.pushLoginScreen(context);
                    } else {
                      StaticNavigator.popContext(context);
                      StaticNavigator.pushLoginScreen(context);
                    }
                  },
                );
              },
            ),
            const ProxySpacingVerticalWidget(
              size: ProxySpacing.extraSmall,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() =>
      const Padding(
        padding: StaticStyles.listViewPadding,
        child: Divider(color: ThemeColors.white),
      );

  //
  // Widget _buildMenuItem({
  //   required String text,
  //   required IconName icon,
  //   required GestureTapCallback onTap,
  //   Color? color = StaticStyles.brandColorWhite,
  //   Color textColor = StaticStyles.brandColorWhite,
  // }) {
  //   return ListTile(
  //     contentPadding: StaticStyles.listViewPadding,
  //     leading: StaticWidgets.getIcon(name: icon, color: color, width: 30, height: 30),
  //     title: ProxyTextWidget(
  //       color: textColor,
  //       text: text,
  //       fontSize: ProxyFontSize.small,
  //     ),
  //     onTap: onTap,
  //   );
  // }

  Widget _buildMenuItemIconData({required String text, required IconData iconData, required GestureTapCallback onTap}) {
    const color = ThemeColors.white;
    const iconColor = ThemeColors.white;


    return ListTile(
      contentPadding: StaticStyles.listViewPadding,
      leading: Icon(
        iconData,
        color: iconColor,
        size: 30,
      ),
      title: ProxyTextWidget(
        color: color,
        text: text,
        fontSize: ProxyFontSize.small,
      ),
      onTap: onTap,
    );
  }

  Widget _buildMenuSubItem(String text, VoidCallback onTap) {
    const color = ThemeColors.white;

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: StaticStyles.listViewPadding,
        child: ProxyTextWidget(
          color: color,
          text: text,
        ),
      ),
    );
  }
}
