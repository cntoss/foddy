import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:foody/common/app_constant.dart';
import 'package:foody/presentation/product/mode/product_model.dart';
import 'package:foody/presentation/product/ui/product_detail.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

// import '../../profile/profile_router.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late DatabaseReference _database;
  final TextEditingController _textController = TextEditingController();
  List<ProductModel> _products = [];
  String _query = '';
  @override
  void initState() {
    super.initState();
    _database = FirebaseDatabase.instance.ref('Products');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.95,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: const Color(0xFFEEEEEE),
                width: 2,
              ),
            ),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(4, 0, 4, 0),
                    child: Icon(
                      Icons.search_rounded,
                      color: Color(0xFF95A1AC),
                      size: 24,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                      child: TextFormField(
                        obscureText: false,
                        controller: _textController,
                        onChanged: (value) {
                          setState(() {
                            _query = value;
                          });
                        },
                        decoration: const InputDecoration(
                          hintText: 'Search Product Here...',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0),
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0),
                            ),
                          ),
                        ),
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontFamily: 'Lexend Deca',
                              color: const Color(0xFF95A1AC),
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(0.95, 0),
                    child: IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: Color(0xFF95A1AC),
                        size: 24,
                      ),
                      onPressed: () => _textController.clear(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        /*  TextField(onChanged: (value) {
              setState(() {
                _database = FirebaseDatabase.instance
                    .ref('Products')
                    .orderByChild('name')
                    .equalTo(value)
                    /* .equalTo(//todo : 
                      value,
                    ) */
                    .ref;
                /* .where('fieldName', isGreaterThanOrEqualTo: searchKey)
                    .where('fieldName', isLessThan: searchKey + 'z')
                    .snapshots() */
              });
            }), */
        Expanded(
          child: StreamBuilder(
              stream: _database.onValue,
              /*  loadingBuilder: (context) =>
                      const Center(child: CircularProgressIndicator()),
                  errorBuilder: (context, error, stackTrace) => Center(
                        child: Text(error.toString()),
                      ), */
              builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.snapshot.value == null) {
                    return const Center(child: Text("No product found"));
                  } else {
                    Map<String, dynamic> data =
                        jsonDecode(jsonEncode(snapshot.data!.snapshot.value))
                            as Map<String, dynamic>;
                    if (_query.length >= 2) {
                      _products.clear();
                      for (var element in data.values) {
                        if (element['name']
                            .toUpperCase()
                            .contains(_query.toUpperCase())) {
                          _products.add(ProductModel.fromJson(element));
                        }
                      }
                    } else {
                      _products = List<ProductModel>.from(
                          data.values.map((x) => ProductModel.fromJson(x)));
                    }
                    return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                        itemCount: _products.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => ProductDetailScreen(
                                            product: _products[index],
                                          ))),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).backgroundColor,
                                    borderRadius: BorderRadius.circular(8.0),
                                    boxShadow: [
                                      BoxShadow(
                                        offset: const Offset(0, 7),
                                        blurRadius: 7,
                                        spreadRadius: 1,
                                        color: const Color(0xFFB0CCE1)
                                            .withOpacity(0.40),
                                      )
                                    ],
                                  ),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Expanded(
                                          child: CachedNetworkImage(
                                            imageUrl: _products[index]
                                                    .imageUrl ??
                                                'https://www.healthyeating.org/images/default-source/home-0.0/nutrition-topics-2.0/general-nutrition-wellness/2-2-2-2foodgroups_vegetables_detailfeature_thumb.jpg',
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    Container(
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover,
                                                ),
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(8.0),
                                                  topRight:
                                                      Radius.circular(8.0),
                                                ),
                                              ),
                                            ),
                                            placeholder: (context, url) =>
                                                Container(
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .backgroundColor,
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(8.0),
                                                  topRight:
                                                      Radius.circular(8.0),
                                                ),
                                              ),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Container(
                                              decoration: const BoxDecoration(
                                                color: Colors.redAccent,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(8.0),
                                                  topRight:
                                                      Radius.circular(8.0),
                                                ),
                                              ),
                                              child: const Center(
                                                  child: Text('No Image')),
                                            ),
                                          ),
                                        ),
                                        if (_products[index].name != null)
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Text(_products[index].name!),
                                          ),
                                        if (_products[index].price != null)
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0, vertical: 4.0),
                                            child: Text(
                                                '$currency ${_products[index].price!}'),
                                          ),
                                      ]),
                                ),
                              ));
                        });
                  }
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
        ),
      ],
    );
  }
}
