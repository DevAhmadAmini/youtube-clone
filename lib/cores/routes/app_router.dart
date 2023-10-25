// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
// import 'package:youtube_clone/cores/routes/router_notifier.dart';
// import 'package:youtube_clone/features/auth/pages/login_page.dart';
// import 'package:youtube_clone/features/channel/screens/users_channels.dart';
// import 'package:youtube_clone/features/feed/pages/home_page.dart';
// import 'package:youtube_clone/features/channel/screens/my_channel.dart';

// final goRouterProvider = Provider<GoRouter>(
//   (ref) {
//     final route = ref.read(routerNotifierProvider);
//     return GoRouter(
//       refreshListenable: route,
//       navigatorKey: GlobalKey<NavigatorState>(),
//       initialLocation: "/home",
//       routes: [
//         GoRoute(
//           path: "/home",
//           name: "/home",
//           builder: (context, state) {
//             return const HomePage();
//           },
//         ),
//         GoRoute(
//           path: "/login",
//           name: "/login",
//           builder: (context, state) {
//             return const LoginPage();
//           },
//         ),
//         GoRoute(
//           path: "/user-channel",
//           name: "/user-channel",
//           builder: (context, state) {
//             return const UserChannel();
//           },
//         ),
//         GoRoute(
//           path: "/channel",
//           name: "/channel",
//           builder: (context, state) {
//             return const MyChannel();
//           },
//         ),
//       ],
//       redirect: (context, state) {
//         if (route.isLoggedIn) {
//           return "/home";
//         } else {
//           return "/login";
//         }
//       },
//     );
//   },
// );
