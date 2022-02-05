// import 'package:flutter/cupertino.dart';
// import 'package:messenger_clone/business_logic/view_models/homescreen_viewmodel.dart';
//
// class AppRouter extends RouterDelegate with ChangeNotifier, PopNavigatorRouterDelegateMixin {
//   final GlobalKey<NavigatorState>? navigatorKey1;
//   late final HomeViewModel homeViewModel;
//
//   AppRouter({required this.homeViewModel}): navigatorKey1 = GlobalKey<NavigatorState>() {
//     homeViewModel.addListener(notifyListeners);
//   };
//   @override
//   Widget build(BuildContext context) {
//     return Navigator(
//       key: navigatorKey,
//       pages: [
//
//       ],
//     )
//   }
//
//   @override
//   // TODO: implement navigatorKey
//   GlobalKey<NavigatorState>? get navigatorKey => navigatorKey1;
//
//   @override
//   Future<void> setNewRoutePath(configuration) {
//     // TODO: implement setNewRoutePath
//     throw UnimplementedError();
//   }
//
// }