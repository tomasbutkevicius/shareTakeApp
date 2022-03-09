import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_take/constants/settings.dart';

import 'package:share_take/presentation/routing/navigation_item.dart';
import 'package:share_take/presentation/routing/navigation_params.dart';
import 'package:share_take/presentation/screens/invalid_route/invalid_route_screen.dart';

class NavigationWidget extends StatefulWidget {
  final String path;
  final NavigationItem? item;
  final NavigationParams? params;

  const NavigationWidget({
    Key? key,
    required this.path,
    this.item,
    this.params,
  }) : super(key: key);

  @override
  _NavigationWidgetState createState() => _NavigationWidgetState();
}

class _NavigationWidgetState extends State<NavigationWidget> {
  @override
  void initState() {
    super.initState();
    //TODO: add tracking function for analytics
  }

  @override
  void didUpdateWidget(NavigationWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.item != widget.item) {
      //TODO: add tracking function for analytics
    }
  }

  Widget get _body => widget.item!.body(widget.params);

  PreferredSizeWidget? get _appBar => widget.item!.appBar(widget.params);


  @override
  Widget build(BuildContext context) {
    if (widget.item == null) {
      return Scaffold(
        body: InvalidRouteScreen(
          path: widget.path,
        ),
      );
    }

    return Scaffold(
      appBar: _appBar,
      resizeToAvoidBottomInset: true,
      body: AnimatedSwitcher(
        child: _body,
        switchInCurve: Curves.easeInExpo,
        switchOutCurve: Curves.easeOutExpo,
        duration: SettingsConstants.duration300,
      ),
    );
  }
}
