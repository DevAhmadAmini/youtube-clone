import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final routerNotifierProvider = Provider(
  (ref) => RouteNotifier(),
);

class RouteNotifier extends ChangeNotifier {
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;
  set isLoggedIn(bool value) {
    _isLoggedIn = value;
    notifyListeners();
  }
}
