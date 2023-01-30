import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

class LogoutHelper {
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    final action = FlutterFireUIAction.ofType<SignedOutAction>(context);
    action?.callback(context);
    Navigator.popAndPushNamed(context, '/sign-in');
  }
}
