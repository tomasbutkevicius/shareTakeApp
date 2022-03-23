import 'package:flutter/material.dart';
import 'package:share_take/data/models/user/user_local.dart';
import 'package:share_take/presentation/router/static_navigator.dart';

class UserListCardWidget extends StatelessWidget {
  const UserListCardWidget({Key? key, required this.user,}) : super(key: key);
  
  final UserLocal user;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        StaticNavigator.pushUserDetailScreen(context, user);
      },
      child: ListTile(
        leading: Icon(Icons.person),
        title: Text(user.email),
        trailing: Text(user.firstName),
      ),
    );
  }
}
