/* import 'dart:convert';

import 'package:foody/user/model/user_model.dart';
import 'package:foody/user/ui/add_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../common/app_constant.dart';
import 'profile_screen.dart';

checkToProfile(context) async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    Navigator.pushNamed(context, '/sign-in');
  } else {
    DataSnapshot dataSnapshot =
        await FirebaseDatabase.instance.ref('$userModel/${user.uid}').get();
    if (dataSnapshot.value != null) {
      UserModel user = UserModel.fromJson(
          jsonDecode(jsonEncode(dataSnapshot.value)) as Map<String, dynamic>);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => ProfileScreen(
                    user: user,
                  )));
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const AddUserScreen()));
    }
  }
}
 */