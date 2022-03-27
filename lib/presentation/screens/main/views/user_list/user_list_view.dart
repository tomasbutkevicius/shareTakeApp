import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_take/bloc/helpers/bloc_getter.dart';
import 'package:share_take/bloc/helpers/request_status.dart';
import 'package:share_take/bloc/user_list/user_list_bloc.dart';
import 'package:share_take/constants/static_styles.dart';
import 'package:share_take/presentation/widgets/centered_loader.dart';
import 'package:share_take/presentation/widgets/proxy/spacing/proxy_spacing_widget.dart';
import 'package:share_take/presentation/widgets/user/user_list_card.dart';
import 'package:share_take/presentation/widgets/utilities/static_widgets.dart';

class UserListView extends StatelessWidget {
  const UserListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocGetter.getUserListBloc(context).add(UserListGetEvent());

    return BlocConsumer<UserListBloc, UserListState>(
      listener: (context, state) {
        if (state.status is RequestStatusError) {
          StaticWidgets.showSnackBar(context, (state.status as RequestStatusError).message);
        }
      },
      builder: (context, state) {
        return CenteredLoader(
          isLoading: state.status is RequestStatusLoading,
          showRefresh: state.status is RequestStatusError,
          onRefresh: () {
            BlocGetter.getUserListBloc(context).add(UserListResetEvent());
            BlocGetter.getUserListBloc(context).add(UserListGetEvent());
          },
          child: _body(state),
        );
      },
    );
  }

  Widget _body(UserListState state) {
    return Center(
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: state.userList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: StaticStyles.listViewPadding,
                  child: Column(
                    children: [
                      ProxySpacingVerticalWidget(),
                      UserListCardWidget(user: state.userList[index]),
                      ProxySpacingVerticalWidget(),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
