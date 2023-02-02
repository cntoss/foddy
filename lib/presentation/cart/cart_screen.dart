import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:foody/common/app_constant.dart';
import 'package:foody/presentation/checkout/payment_method.dart';
import 'package:foody/user/model/user_model.dart';
import 'package:foody/utils/toast.dart';

import '../../function/firebase_helper.dart';
import '../../product/mode/product_model.dart';
import '../../user/ui/add_user.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<String> selectedProductsIds = [];
  List<ProductModel> selectedProducts = [];
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IgnorePointer(
          ignoring: isLoading,
          child: StreamBuilder(
              stream: FirebaseDatabase.instance
                  .ref('$userModel/${FirebaseAuth.instance.currentUser!.uid}')
                  .onValue,
              builder: (context, AsyncSnapshot<DatabaseEvent> userSnapshot) {
                if (userSnapshot.hasData) {
                  if (userSnapshot.data!.snapshot.value != null) {
                    UserModel user = UserModel.fromJson(jsonDecode(
                            jsonEncode(userSnapshot.data!.snapshot.value))
                        as Map<String, dynamic>);

                    return StreamBuilder(
                        stream:
                            FirebaseDatabase.instance.ref('Products').onValue,
                        builder: (context,
                            AsyncSnapshot<DatabaseEvent> productSnapshot) {
                          if (productSnapshot.hasData) {
                            if (productSnapshot.data!.snapshot.value == null) {
                              return const Center(child: Text("No Cart found"));
                            } else {
                              Map<String, dynamic> data = jsonDecode(jsonEncode(
                                      productSnapshot.data!.snapshot.value))
                                  as Map<String, dynamic>;
                              List<String> productIds = user.carts ?? [];
                              List<ProductModel> products = [];
                              for (var element in data.values) {
                                if (productIds.contains(element['id'])) {
                                  products.add(ProductModel.fromJson(element));
                                }
                              }
                              return products.isEmpty
                                  ? const Center(child: Text("No Cart found"))
                                  : Stack(
                                      children: [
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                          child: ListView.builder(
                                              itemCount: products.length,
                                              shrinkWrap: true,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return ListTile(
                                                  isThreeLine: true,
                                                  leading: Checkbox(
                                                      value: selectedProductsIds
                                                          .contains(
                                                              products[index]
                                                                  .id),
                                                      onChanged: (val) {
                                                        if (val == true) {
                                                          selectedProductsIds
                                                              .add(products[
                                                                      index]
                                                                  .id!);
                                                          selectedProducts.add(
                                                              products[index]);
                                                        } else {
                                                          selectedProductsIds
                                                              .remove(products[
                                                                      index]
                                                                  .id!);
                                                          selectedProducts
                                                              .remove(products[
                                                                  index]);
                                                        }
                                                        setState(() {});
                                                      }),
                                                  title: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        CachedNetworkImage(
                                                          imageUrl: products[
                                                                      index]
                                                                  .imageUrl ??
                                                              rawImage,
                                                          imageBuilder: (context,
                                                                  imageProvider) =>
                                                              Container(
                                                            width: 70,
                                                            height: 70,
                                                            decoration:
                                                                BoxDecoration(
                                                              image:
                                                                  DecorationImage(
                                                                image:
                                                                    imageProvider,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        8.0),
                                                                topRight: Radius
                                                                    .circular(
                                                                        8.0),
                                                              ),
                                                            ),
                                                          ),
                                                          placeholder:
                                                              (context, url) =>
                                                                  Container(
                                                            width: 70,
                                                            height: 70,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Theme.of(
                                                                      context)
                                                                  .backgroundColor,
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        8.0),
                                                                topRight: Radius
                                                                    .circular(
                                                                        8.0),
                                                              ),
                                                            ),
                                                          ),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              Container(
                                                            width: 70,
                                                            height: 70,
                                                            decoration:
                                                                const BoxDecoration(
                                                              color: Colors
                                                                  .redAccent,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        8.0),
                                                                topRight: Radius
                                                                    .circular(
                                                                        8.0),
                                                              ),
                                                            ),
                                                            child: const Center(
                                                                child: Text(
                                                                    'No Image')),
                                                          ),
                                                        ),
                                                        products[index].name !=
                                                                null
                                                            ? Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        8.0),
                                                                child: Text(
                                                                    products[
                                                                            index]
                                                                        .name!),
                                                              )
                                                            : const Text(
                                                                "Unknown Name"),
                                                      ]),
                                                  subtitle: products[index]
                                                              .price !=
                                                          null
                                                      ? Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      8.0,
                                                                  vertical:
                                                                      4.0),
                                                          child: Text(
                                                              '$currency ${products[index].price!}'),
                                                        )
                                                      : const Text(
                                                          'Unknown Amount'),
                                                );
                                              }),
                                        ),
                                        if (selectedProductsIds.isNotEmpty)
                                          Positioned(
                                            bottom: 0,
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              color: Colors.lightBlue
                                                  .withOpacity(0.5),
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 8,
                                                  horizontal:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          3.5),
                                              child: ElevatedButton(
                                                  onPressed: () async {
                                                    try {
                                                      setState(() {
                                                        isLoading = true;
                                                      });

                                                      String? mes =
                                                          await FirebaseHelper()
                                                              .checkout(
                                                                  selectedProductsIds);
                                                      /*  showToast(
                                                          mes ?? 'Success'); */
                                                      setState(() {
                                                        isLoading = false;
                                                      });
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (_) =>
                                                                  PaymentMethodScreen(
                                                                      products:
                                                                          selectedProducts)));
                                                    } catch (e) {
                                                      setState(() {
                                                        isLoading = false;
                                                      });
                                                      showToast(e.toString());
                                                    }
                                                  },
                                                  child:
                                                      const Text('Checkout')),
                                            ),
                                          )
                                      ],
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
                    return Center(
                        child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const AddUserScreen()));
                      },
                      child: const Text('Add Profile'),
                    ));
                  }
                } else if (userSnapshot.hasError) {
                  return Text(userSnapshot.error.toString());
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
        ),
        if (isLoading)
          Positioned(
              top: MediaQuery.of(context).size.height / 3,
              left: MediaQuery.of(context).size.width / 2,
              child: const Center(child: CircularProgressIndicator()))
      ],
    );
  }
}
