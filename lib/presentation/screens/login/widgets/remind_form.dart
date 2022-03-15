// import 'package:boost_your_love/business_logic/blocs/authentication/authentication_bloc.dart';
// import 'package:boost_your_love/constants/enums.dart';
// import 'package:boost_your_love/constants/styling/static_styles.dart';
// import 'package:boost_your_love/localization/translations.dart';
// import 'package:boost_your_love/presentation/widgets/proxy/button/proxy_button_widget.dart';
// import 'package:boost_your_love/presentation/widgets/proxy/input/proxy_text_form_field.dart';
// import 'package:boost_your_love/presentation/widgets/proxy/spacing/proxy_spacing_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:provider/src/provider.dart';
//
// class RemindForm extends StatefulWidget {
//   const RemindForm({Key? key}) : super(key: key);
//
//   @override
//   _LoginFormState createState() => _LoginFormState();
// }
//
// class _LoginFormState extends State<RemindForm> {
//   late final TextEditingController _emailController = TextEditingController();
//   final focus = FocusNode();
//   final _formKey = GlobalKey<FormState>();
//
//
//   @override
//   void dispose() {
//     _emailController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Padding(
//         padding: StaticStyles.listViewPadding,
//         child: Column(
//           children: <Widget>[
//             _emailField(context),
//             const ProxySpacingVerticalWidget(),
//             const ProxySpacingVerticalWidget(
//               size: ProxySpacing.extraLarge,
//             ),
//             _getSubmitBtn(context),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _emailField(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         Expanded(
//           child: ConstrainedBox(
//             constraints: BoxConstraints(
//               maxWidth: 480,
//             ),
//             child: ProxyTextFormField(
//               controller: _emailController,
//               textInputAction: TextInputAction.next,
//               validator: (input) {
//                 if(input == null){
//                   return Translations.textCannotBeEmpty;
//                 } else {
//                   if(input.trim().isEmpty){
//                     return Translations.textCannotBeEmpty;
//                   }
//                 }
//               },
//               onFieldSubmitted: (v) {
//                 FocusScope.of(context).requestFocus(focus);
//               },
//               labelText: "Email",
//               icon: Icon(
//                 Icons.person,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _getSubmitBtn(BuildContext context) {
//     return ProxyButtonWidget(
//       padding: const EdgeInsets.symmetric(
//         vertical: 12.0,
//         horizontal: 20.0,
//       ),
//       text: Translations.sendReminder,
//       color: StaticStyles.brandColorDarkBlue,
//       isUppercase: false,
//       onPressed: () {
//         if(_formKey.currentState!.validate()){
//           context.read<AuthenticationBloc>().add(
//             RemindPasswordEvent(
//               email: _emailController.text,
//             ),
//           );
//         }
//       },
//     );
//   }
// }
