// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:uni_links/uni_links.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:umraah_app/presentation/reset_password/bloc/reset_password_cubit.dart';
//
// import '../reset_password/view/reset_password_view.dart';
//
// class AppWithDeepLinkHandler extends StatefulWidget {
//   final Widget child;
//
//   const AppWithDeepLinkHandler({super.key, required this.child});
//
//   @override
//   State<AppWithDeepLinkHandler> createState() => _AppWithDeepLinkHandlerState();
// }
//
// class _AppWithDeepLinkHandlerState extends State<AppWithDeepLinkHandler> {
//   StreamSubscription? _sub;
//
//   @override
//   void initState() {
//     super.initState();
//     _initDeepLinks();
//   }
//
//   void _initDeepLinks() async {
//     try {
//       // When app is killed and started by link
//       final initialLink = await getInitialLink();
//       if (initialLink != null) _handleLink(initialLink);
//
//       // When app is already running
//       _sub = linkStream.listen((String? link) {
//         if (link != null) _handleLink(link);
//       });
//     } catch (e) {
//       debugPrint("Error handling deep link: $e");
//     }
//   }
//
//   void _handleLink(String link) {
//     final uri = Uri.parse(link);
//
//     if (uri.path.contains("resetPassword") && uri.queryParameters.containsKey("token")) {
//       final token = uri.queryParameters["token"]!;
//       Navigator.of(context).push(
//         MaterialPageRoute(
//           builder: (_) => BlocProvider.value(
//             value: context.read<ResetPasswordCubit>(),
//             child: ResetPasswordScreen(token: token),
//           ),
//         ),
//       );
//     }
//   }
//
//   @override
//   void dispose() {
//     _sub?.cancel();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return widget.child;
//   }
// }
