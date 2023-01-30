import 'dart:convert';

import 'package:foody/user/model/user_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/database.dart';

import '../../common/app_constant.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Users'), centerTitle: true),
      body: FirebaseDatabaseListView(
          query: FirebaseDatabase.instance.ref(userModel),
          loadingBuilder: (context) =>
              const Center(child: CircularProgressIndicator()),
          errorBuilder: (context, error, stackTrace) => Center(
                child: Text(error.toString()),
              ),
          itemBuilder: (context, DataSnapshot snapshot) {
            if (snapshot.value == null) {
              return const Center(child: Text("No product found"));
            } else {
              Map<String, dynamic> data = jsonDecode(jsonEncode(snapshot.value))
                  as Map<String, dynamic>;
              UserModel _user = UserModel.fromJson(data);

              return Card(
                child: ListTile(
                  title: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(_user.userDisplayName ?? 'Unknown'),
                  ),
                  subtitle: _user.address != null
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 4.0),
                          child: Text('$currency ${_user.address!}'),
                        )
                      : const Text('Unknown Address'),
                ),
              );
            }
          }),
    );
  }
}
