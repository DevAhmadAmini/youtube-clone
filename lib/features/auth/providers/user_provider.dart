import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/features/auth/data/repository/user_data_service.dart';
import '../data/model/user.dart';

final userDataProvider = FutureProvider<UserModel>((ref) async {
  final UserModel user =
      await ref.read(userDataServiceProvider).retrieveUserData();
  return user;
});
