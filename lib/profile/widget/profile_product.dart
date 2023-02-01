import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../common/app_constant.dart';
import '../../function/firebase_helper.dart';
import '../../product/mode/product_model.dart';
import '../../product/ui/add_product.dart';

class ProfileProductsScreen extends StatelessWidget {
  const ProfileProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Foods')),
      floatingActionButton: ElevatedButton.icon(
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (_) => const AddProduct())),
          icon: const Icon(Icons.add),
          label: const Text('Add Food')),
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            )),
        child: StreamBuilder(
            stream: FirebaseDatabase.instance.ref('Products').onValue,
            builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.snapshot.value == null) {
                  return const Center(child: Text("No Food found"));
                } else {
                  Map<String, dynamic> data =
                      jsonDecode(jsonEncode(snapshot.data!.snapshot.value))
                          as Map<String, dynamic>;
                  List<ProductModel> products = [];
                  for (var element in data.values) {
                    if (element['ownerId'] ==
                        FirebaseAuth.instance.currentUser!.uid) {
                      products.add(ProductModel.fromJson(element));
                    }
                  }
                  return products.isEmpty
                      ? const Center(child: Text("You dont have food"))
                      : ListView.builder(
                          itemCount: products.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              isThreeLine: true,
                              leading: CachedNetworkImage(
                                imageUrl: products[index].imageUrl ?? rawImage,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  width: 70,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(8.0),
                                      topRight: Radius.circular(8.0),
                                    ),
                                  ),
                                ),
                                placeholder: (context, url) => Container(
                                  width: 70,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).backgroundColor,
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(8.0),
                                      topRight: Radius.circular(8.0),
                                    ),
                                  ),
                                ),
                                errorWidget: (context, url, error) => Container(
                                  width: 70,
                                  decoration: const BoxDecoration(
                                    color: Colors.redAccent,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8.0),
                                      topRight: Radius.circular(8.0),
                                    ),
                                  ),
                                  child: const Center(child: Text('No Image')),
                                ),
                              ),
                              title: products[index].name != null
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Text(products[index].name!),
                                    )
                                  : const Text("Unknown Name"),
                              subtitle: products[index].price != null
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 4.0),
                                      child: Text(
                                          '$currency ${products[index].price!}'),
                                    )
                                  : const Text('Unknown Amount'),
                              trailing: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => AddProduct(
                                                      product: products[index],
                                                    )));
                                      },
                                      child: const Icon(Icons.edit)),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                  InkWell(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (_) => AlertDialog(
                                                  title: const Text('Delete'),
                                                  content: const Text(
                                                      'Are you sure to delete this food'),
                                                  actions: [
                                                    Row(
                                                      children: [
                                                        ElevatedButton(
                                                            style: ElevatedButton
                                                                .styleFrom(
                                                                    primary:
                                                                        Colors
                                                                            .red),
                                                            onPressed: () {
                                                              if (products[
                                                                          index]
                                                                      .id !=
                                                                  null) {
                                                                FirebaseHelper()
                                                                    .removeFile(
                                                                        products[index]
                                                                            .imageUrl);
                                                                FirebaseHelper()
                                                                    .deleteProduct(
                                                                        products[index]
                                                                            .id!);
                                                              }
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: const Text(
                                                                'Okay')),
                                                        const Spacer(),
                                                        ElevatedButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: const Text(
                                                                'Cancel'))
                                                      ],
                                                    ),
                                                  ],
                                                ));
                                      },
                                      child: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ))
                                ],
                              ),
                            );
                          });
                }
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}
