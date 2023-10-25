// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:youtube_clone/features/auth/data/repository/user_auth_service.dart';
// import 'package:youtube_clone/features/auth/data/repository/user_data_service.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../data/model/user.dart';

// final userRepositoryProvider = Provider(
//   (ref) => UserRepository(
//     authService: ref.read(userAuthServiceProvider),
//     userService: ref.read(userDataServiceProvider),
//   ),
// );

// class UserRepository {
//   final AuthService authService;
//   final UserService userService;
//   UserRepository({
//     required this.authService,
//     required this.userService,
//   });

//   signInWithGoogle() async {
//     final GoogleSignInAccount user = await authService.signInWithGoogle();
//     return user;
//   }

//   Future<void> addUserInfo(
//       GoogleSignInAccount user, String userId, username) async {
//     await userService.addUserDataToFirestore(user, userId, username);
//   }

//   Future<UserModel> getUserInfo() async {
//     final UserModel user = await userService.retrieveUserData();
//     return user;
//   }
// }
