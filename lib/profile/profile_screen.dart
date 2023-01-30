import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:foody/profile/widget/profile_product.dart';
import 'package:foody/user/model/user_model.dart';
import 'package:foody/user/ui/user_list_screen.dart';

import '../common/app_constant.dart';
import '../user/ui/add_user.dart';
import 'widget/profile_card.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseDatabase.instance
            .ref('$userModel/${FirebaseAuth.instance.currentUser!.uid}')
            .onValue,
        builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.snapshot.value != null) {
              UserModel user = UserModel.fromJson(
                  jsonDecode(jsonEncode(snapshot.data!.snapshot.value))
                      as Map<String, dynamic>);

              return Column(mainAxisSize: MainAxisSize.min, children: [
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(children: [
                      const SizedBox(height: 20),
                      Container(
                        height: 80,
                        width: 80,
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        child: CachedNetworkImage(
                          imageUrl: user.profileUrl ??
                              'https://picsum.photos/1000/1000',
                          fit: BoxFit.cover,
                          fadeInDuration: const Duration(milliseconds: 250),
                          fadeOutDuration: const Duration(milliseconds: 250),
                          width: 99,
                          height: 99,
                          errorWidget: (_, __, ___) {
                            return const CircleAvatar(
                              radius: 45,
                              backgroundColor: Colors.blueGrey,
                              child: SizedBox(
                                width: 99,
                                height: 99,
                                child: Icon(
                                  Icons.person,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        user.userDisplayName ?? "Name",
                        style: ThemeData().textTheme.headline1?.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                            color: Colors.black),
                      ),
                      const SizedBox(height: 8),
                      Text.rich(TextSpan(children: [
                        const WidgetSpan(
                            child: Padding(
                          padding: EdgeInsets.only(right: 4.0, top: 0.0),
                          child: Icon(
                            Icons.phone,
                            color: Colors.black45,
                            size: 20,
                          ),
                        )),
                        TextSpan(
                          text: user.phone ?? 'N/A',
                          style: ThemeData().textTheme.headline1?.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Colors.black45),
                        ),
                      ])),
                      const SizedBox(height: 8),
                      Text.rich(TextSpan(children: [
                        const WidgetSpan(
                            child: Padding(
                          padding: EdgeInsets.only(right: 4.0, top: 0.0),
                          child: Icon(
                            Icons.location_city,
                            color: Colors.black45,
                            size: 20,
                          ),
                        )),
                        TextSpan(
                          text: user.address ?? 'N/A',
                          style: ThemeData().textTheme.headline1?.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Colors.black45),
                        ),
                      ])),
                    ])),
                ProfileCard(
                  text: 'Edit Profile',
                  padding: 18,
                  trailing: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                      color: Colors.white30,
                    ),
                    child: const Icon(
                      Icons.arrow_forward,
                      color: Colors.blueAccent,
                    ),
                  ),
                  leadingIcon: Icons.edit,
                  onPressed: () {
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => AddUserScreen(user: user)))
                        .then((value) async {
                      /*   if (value == true) {
                        DataSnapshot dataSnapshot = await FirebaseDatabase
                            .instance
                            .ref('Users/${user.id}')
                            .get();
                        if (dataSnapshot.value != null) {
                          UserModel user = UserModel.fromJson(
                              jsonDecode(jsonEncode(dataSnapshot.value))
                                  as Map<String, dynamic>);
                          setState(() {
                            user = user;
                          });
                        }
                      } */
                    });
                  },
                ),
                ProfileCard(
                  text: 'Order history',
                  padding: 18,
                  trailing: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                      color: Colors.white30,
                    ),
                    child: const Icon(
                      Icons.arrow_forward,
                      color: Colors.blueAccent,
                    ),
                  ),
                  leadingIcon: Icons.local_shipping,
                  onPressed: () {
                    // context.router.pushNamed(AppRoutes.orderHistoryPath);
                  },
                ),
                ProfileCard(
                  text: 'My products',
                  padding: 18,
                  trailing: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                      color: Colors.white30,
                    ),
                    child: const Icon(
                      Icons.arrow_forward,
                      color: Colors.blueAccent,
                    ),
                  ),
                  leadingIcon: Icons.inventory,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const ProfileProductsScreen()));
                  },
                ),
                ProfileCard(
                  text: 'Users',
                  padding: 18,
                  trailing: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                      color: Colors.white30,
                    ),
                    child: const Icon(
                      Icons.arrow_forward,
                      color: Colors.blueAccent,
                    ),
                  ),
                  leadingIcon: Icons.group,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const UserListScreen()));
                  },
                ),
              ]);
            } else {
              return Center(
                  child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const AddUserScreen()));
                },
                child: const Text('Add Profile'),
              ));
            }
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
