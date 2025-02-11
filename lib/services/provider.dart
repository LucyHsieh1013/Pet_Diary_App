import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/provider/UserInformation.dart';
import 'package:test_app/provider/PetInformation.dart';

// 重置Provider
void resetAllProviders(BuildContext context) {
  Provider.of<UserProvider>(context, listen: false).reset();
  Provider.of<PetProvider>(context, listen: false).reset();
}

// 加載Provider
Future<void> loadAllProviders(BuildContext context) async {
  await Provider.of<UserProvider>(context, listen: false).fetchUser();
  await Provider.of<PetProvider>(context, listen: false).fetchPet();

}