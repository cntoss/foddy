import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody/common/app_constant.dart';
import 'package:foody/user/model/user_model.dart';
import 'package:foody/utils/toast.dart';

import '../../function/firebase_helper.dart';
import '../../product/mode/product_model.dart';
import '../cubit/bottom_nav_cubit/bottom_nav_cubit.dart';

class ConfirmationScreen extends StatefulWidget {
  final List<ProductModel> products;
  final String? methodname;
  const ConfirmationScreen(
      {super.key, required this.products, required this.methodname});

  @override
  State<ConfirmationScreen> createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  num totalAmount = 0;
  String selectedMethod = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    for (ProductModel product in widget.products) {
      totalAmount += num.parse(product.price ?? '0');
    }
  }

  // bool isLoading = false;

/*   getSupplier() async {
    UserModel? user = await FirebaseHelper().checkUser(widget.product.ownerId!);
    if (user != null) {
      setState(() {
        _supplier = user;
      });
    }
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Placed'),
        leading: const SizedBox(),
      ),
      body: Container(
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            )),
        child: FutureBuilder<UserModel>(
            future: FirebaseHelper().checkUser(),
            builder: (context, AsyncSnapshot<UserModel> usersnapshot) {
              if (usersnapshot.hasData) {
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Congratulation!!! Your order has been placed.',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Order\'s information:.',
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text('Delivery location: ${usersnapshot.data?.address}'),
                      Text('Phone number: ${usersnapshot.data?.phone}'),
                      Text('Selected Payment method: ${widget.methodname}'),
                      Text('Total amount: $totalAmount'),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text('Orderd items:'),
                      const SizedBox(
                        height: 4,
                      ),
                      Expanded(
                        child: ListView.builder(
                            itemCount: widget.products.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                isThreeLine: true,
                                title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl:
                                            widget.products[index].imageUrl ??
                                                rawImage,
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          width: 70,
                                          height: 70,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                            ),
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(8.0),
                                              topRight: Radius.circular(8.0),
                                            ),
                                          ),
                                        ),
                                        placeholder: (context, url) =>
                                            Container(
                                          width: 70,
                                          height: 70,
                                          decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .backgroundColor,
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(8.0),
                                              topRight: Radius.circular(8.0),
                                            ),
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Container(
                                          width: 70,
                                          height: 70,
                                          decoration: const BoxDecoration(
                                            color: Colors.redAccent,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(8.0),
                                              topRight: Radius.circular(8.0),
                                            ),
                                          ),
                                          child: const Center(
                                              child: Text('No Image')),
                                        ),
                                      ),
                                      widget.products[index].name != null
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              child: Text(
                                                  widget.products[index].name!),
                                            )
                                          : const Text("Unknown Name"),
                                    ]),
                                subtitle: widget.products[index].price != null
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0, vertical: 4.0),
                                        child: Text(
                                            '$currency ${widget.products[index].price!}'),
                                      )
                                    : const Text('Unknown Amount'),
                              );
                            }),
                      ),
                      Center(
                          child: Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: ElevatedButton(
                            onPressed: () {
                              /*  showToast(
                                  'Congratulation!!! Your order has been placed, goto profile->my order to track your order');
                               */
                              BlocProvider.of<BottomNavCubit>(context)
                                  .resetNavIndex(index: 0);
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            child: const Text('Continue Shopping')),
                      ))
                    ]);
              } else if (usersnapshot.hasError) {
                return Text(usersnapshot.error.toString());
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}
