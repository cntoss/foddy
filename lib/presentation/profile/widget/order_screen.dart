import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../../common/app_constant.dart';
import '../../product/mode/product_model.dart';
import '../../user/model/user_model.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Orders')),
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            )),
        child: StreamBuilder(
            stream: FirebaseDatabase.instance
                .ref('$userModel/${FirebaseAuth.instance.currentUser!.uid}')
                .onValue,
            builder: (context, AsyncSnapshot<DatabaseEvent> userSnapshot) {
              if (userSnapshot.hasData) {
                if (userSnapshot.data!.snapshot.value != null) {
                  UserModel user = UserModel.fromJson(
                      jsonDecode(jsonEncode(userSnapshot.data!.snapshot.value))
                          as Map<String, dynamic>);

                  return StreamBuilder(
                      stream: FirebaseDatabase.instance.ref('Products').onValue,
                      builder: (context,
                          AsyncSnapshot<DatabaseEvent> productSnapshot) {
                        if (productSnapshot.hasData) {
                          if (productSnapshot.data!.snapshot.value == null) {
                            return const Center(child: Text("No Order found"));
                          } else {
                            Map<String, dynamic> data = jsonDecode(jsonEncode(
                                    productSnapshot.data!.snapshot.value))
                                as Map<String, dynamic>;
                            List<String> productIds = user.orders ?? [];
                            List<ProductModel> allProducts =
                                List<ProductModel>.from(data.values
                                    .map((e) => ProductModel.fromJson(e)));
                            List<ProductModel> products = [];
                            for (int i = 0; i < productIds.length; i++) {
                              // if (allProducts.firstWhere((element) => element.id == productIds[i])) {

                              products.add(allProducts.firstWhere(
                                  (element) => element.id == productIds[i],
                                  orElse: () => ProductModel()));
                              //}
                            }
                            return products.isEmpty
                                ? const Center(child: Text("No Order found"))
                                : SizedBox(
                                    height: MediaQuery.of(context).size.height,
                                    child: ListView.builder(
                                        itemCount: products.length,
                                        shrinkWrap: true,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          if (products[index].id == null) {
                                            return const SizedBox();
                                          }
                                          return ListTile(
                                            isThreeLine: true,
                                            title: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  CachedNetworkImage(
                                                    imageUrl: products[index]
                                                            .imageUrl ??
                                                        rawImage,
                                                    imageBuilder: (context,
                                                            imageProvider) =>
                                                        Container(
                                                      width: 70,
                                                      height: 70,
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                          image: imageProvider,
                                                          fit: BoxFit.cover,
                                                        ),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  8.0),
                                                          topRight:
                                                              Radius.circular(
                                                                  8.0),
                                                        ),
                                                      ),
                                                    ),
                                                    placeholder:
                                                        (context, url) =>
                                                            Container(
                                                      width: 70,
                                                      height: 70,
                                                      decoration: BoxDecoration(
                                                        color: Theme.of(context)
                                                            .backgroundColor,
                                                        borderRadius:
                                                            const BorderRadius
                                                                .only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  8.0),
                                                          topRight:
                                                              Radius.circular(
                                                                  8.0),
                                                        ),
                                                      ),
                                                    ),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Container(
                                                      width: 70,
                                                      height: 70,
                                                      decoration:
                                                          const BoxDecoration(
                                                        color: Colors.redAccent,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  8.0),
                                                          topRight:
                                                              Radius.circular(
                                                                  8.0),
                                                        ),
                                                      ),
                                                      child: const Center(
                                                          child:
                                                              Text('No Image')),
                                                    ),
                                                  ),
                                                  products[index].name != null
                                                      ? Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      8.0),
                                                          child: Text(
                                                              products[index]
                                                                  .name!),
                                                        )
                                                      : const Text(
                                                          "Unknown Name"),
                                                ]),
                                            subtitle: products[index].price !=
                                                    null
                                                ? Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 8.0,
                                                        vertical: 4.0),
                                                    child: Text(
                                                        '$currency ${products[index].price!}'),
                                                  )
                                                : const Text('Unknown Amount'),
                                          );
                                        }),
                                  );
                          }
                        } else if (productSnapshot.hasError) {
                          return Text(productSnapshot.error.toString());
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      });
                } else {
                  return const Center(child: Text('No User found'));
                }
              } else if (userSnapshot.hasError) {
                return Text(userSnapshot.error.toString());
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}
