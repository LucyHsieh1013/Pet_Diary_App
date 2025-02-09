import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/provider/UserInformation.dart';

// 重置Provider
void resetAllProviders(BuildContext context) {
  Provider.of<UserProvider>(context, listen: false).resetUser();
}

// 加載Provider
Future<void> loadAllProviders(BuildContext context) async {
  await Provider.of<UserProvider>(context, listen: false).fetchUser();
}