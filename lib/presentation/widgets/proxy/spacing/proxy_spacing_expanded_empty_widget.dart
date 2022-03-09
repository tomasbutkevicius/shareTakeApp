import 'package:flutter/cupertino.dart';

class ProxySpacingExpandedEmptyWidget extends StatelessWidget {
  final int flex;

  const ProxySpacingExpandedEmptyWidget({
    Key? key,
    this.flex = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: SizedBox(
        width: 0,
        child: Center(
          child: Container(),
        ),
      ),
    );
  }
}