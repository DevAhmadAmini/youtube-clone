// import 'package:flutter/material.dart';
// import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

// import '../features/home/auth/login_page.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   PersistentTabController bottomNavigationController =
//       PersistentTabController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: PersistentTabView(
//         context,
//         screens: const [
//           LoginPage(),
//           LoginPage(),
//           LoginPage(),
//           LoginPage(),
//         ],
//         controller: bottomNavigationController,
//         items: [
//           PersistentBottomNavBarItem(
//             icon: const Icon(Icons.home),
//             title: "Home",
//           ),
//           PersistentBottomNavBarItem(
//             icon: const Icon(Icons.home),
//             title: "Shorts",
//           ),
//           PersistentBottomNavBarItem(
//             icon: const Icon(Icons.home),
//             title: "Subscriptions",
//           ),
//           PersistentBottomNavBarItem(
//             icon: const Icon(Icons.home),
//             title: "Library",
//           ),
//         ],
//       ),
//     );
//   }
// }
