
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_take/bloc/bottom_main_navigation/bottom_main_navigation_bloc.dart';
import 'package:share_take/constants/theme/theme_colors.dart';
import 'package:share_take/presentation/widgets/utilities/static_widgets.dart';

import '../../../../constants/enums.dart';

class MainBottomNavigationWidget extends StatelessWidget {
  /// It is okay not to use a const constructor here.
  /// Using const breaks updating of selected BottomNavigationBarItem.
  // ignore: prefer_const_constructors_in_immutables
  MainBottomNavigationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color activeColor = ThemeColors.blue;
    Color defaultColor = ThemeColors.blue.withOpacity(0.5);
    Color activeLineColor = activeColor;
    Color defaultLineColor = ThemeColors.white;

    return Card(
      margin: const EdgeInsets.only(top: 2, right: 0, left: 0),
      elevation: 0,
      color: Theme.of(context).bottomAppBarColor,
      child: BottomNavigationBar(
        currentIndex: context.read<BottomMainNavigationBloc>().state.viewIndex,
        onTap: (index) {
            context.read<BottomMainNavigationBloc>().add(BottomMainNavigationClickEvent(index));
        },
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        backgroundColor: Colors.transparent,
        selectedItemColor: activeColor,
        unselectedItemColor: defaultColor,
        items: [
          BottomNavigationBarItem(
            activeIcon: _buildNavItemIconData(
              icon: Icons.menu_book,
              iconColor: activeColor,
              topLineColor: activeLineColor,
            ),
            icon: _buildNavItemIconData(
              icon: Icons.menu_book,
              iconColor: defaultColor,
              topLineColor: defaultLineColor,
            ),
            label: "Books",
          ),
          BottomNavigationBarItem(
            activeIcon: _buildNavItemIconData(
              icon: Icons.supervised_user_circle_sharp,
              iconColor: activeColor,
              topLineColor: activeLineColor,
            ),
            icon: _buildNavItemIconData(
              icon: Icons.supervised_user_circle_sharp,
              iconColor: defaultColor,
              topLineColor: defaultLineColor,
            ),
            label: "Users",
          ),
          BottomNavigationBarItem(
            activeIcon: _buildNavItemIconData(
              icon: Icons.swap_horizontal_circle_outlined,
              iconColor: activeColor,
              topLineColor: activeLineColor,
            ),
            icon: _buildNavItemIconData(
              icon: Icons.swap_horizontal_circle_outlined,
              iconColor: defaultColor,
              topLineColor: defaultLineColor,
            ),
            label: "Trades",
          ),
        ],
      ),
    );
  }


  Widget _buildNavItemIconData({required IconData icon, required Color iconColor, required Color topLineColor}) {
    return SizedBox(
      width: double.infinity,
      child: Center(
        child: Stack(
          clipBehavior: Clip.none,
          fit: StackFit.loose,
          children: [
            SizedBox(
              width: double.infinity,
              child:Icon(
                icon,
                color: iconColor,
                size: 30,
              ),
            ),
            Positioned(
              top: -10,
              left: 0,
              right: 0,
              child: Container(
                height: 4.0,
                color: topLineColor,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildNavItemIcon({required IconName iconName, required Color iconColor, required Color topLineColor}) {
    return SizedBox(
      width: double.infinity,
      child: Center(
        child: Stack(
          clipBehavior: Clip.none,
          fit: StackFit.loose,
          children: [
            SizedBox(
              width: double.infinity,
              child: StaticWidgets.getIcon(
                name: iconName,
                width: 30,
                height: 30,
                color: iconColor,
              ),
            ),
            Positioned(
              top: -10,
              left: 0,
              right: 0,
              child: Container(
                height: 4.0,
                color: topLineColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
