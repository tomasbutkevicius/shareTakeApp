// import 'package:boost_your_love/business_logic/blocs/authentication/authentication_bloc.dart';
// import 'package:boost_your_love/business_logic/other/form_submission_status.dart';
// import 'package:boost_your_love/constants/enums.dart';
// import 'package:boost_your_love/constants/styling/static_styles.dart';
// import 'package:boost_your_love/localization/translations.dart';
// import 'package:boost_your_love/presentation/screens/login/widgets/remind_form.dart';
// import 'package:boost_your_love/presentation/widgets/custom_app_bar.dart';
// import 'package:boost_your_love/utilities/static_widgets.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class RemindPassword extends StatelessWidget {
//   const RemindPassword({Key? key}) : super(key: key);
//   static const routeName = "/remindPassword";
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar.build(
//         context,
//         showBackBtn: true,
//         showTitle: false,
//       ),
//       backgroundColor: StaticStyles.backgroundColor,
//       body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
//         listener: (context, state) {
//           if (state.formStatus is SubmissionFailed) {
//             SubmissionFailed status = state.formStatus as SubmissionFailed;
//
//             StaticWidgets.showSnackBar(context, status.message);
//           }
//
//           if (state.formStatus is SubmissionSuccess) {
//             StaticWidgets.showSnackBar(context, Translations.messageSent);
//           }
//         },
//         builder: (context, state) {
//           if (state.formStatus is FormSubmitting) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//
//           return Flex(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               direction: Axis.vertical,
//               children: <Widget>[
//                 Flexible(
//                   flex: 1,
//                   child: _buildAppLogo(),
//                 ),
//                 Flexible(
//                   flex: 1,
//                   child: RemindForm(),
//                 ),
//               ]);
//         },
//       ),
//     );
//   }
//
//   Widget _buildAppLogo() {
//     return Padding(
//       padding: StaticStyles.headerPadding,
//       child: StaticWidgets.getIcon(name: IconName.landingLogo),
//     );
//   }
// }
