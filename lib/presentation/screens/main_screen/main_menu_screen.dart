import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_take/bloc/bottom_main_navigation/bottom_main_navigation_bloc.dart';
import 'package:share_take/constants/settings.dart';
import 'package:share_take/presentation/screens/main_screen/widgets/bottom_nav_bar.dart';
import 'package:share_take/presentation/widgets/custom_app_bar.dart';
import 'package:share_take/presentation/widgets/drawer_widget.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);
  static const routeName = "/";

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomMainNavigationBloc, BottomMainNavigationState>(
      builder: (BuildContext context, BottomMainNavigationState state) {
        return Scaffold(
          appBar: CustomAppBar.build(
            context,
            showBackBtn: false,
          ),
          drawer: const DrawerWidget(),
          body: AnimatedSwitcher(
            duration: StaticSettings.duration300ms,
            child: state.getSelectedView(),
          ),
          bottomNavigationBar: MainBottomNavigationWidget(),
        );
      },
    );
  }
}
