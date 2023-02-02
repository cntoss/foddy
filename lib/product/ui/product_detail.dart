import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody/common/app_constant.dart';
import 'package:foody/core/static_color.dart';
import 'package:foody/function/firebase_helper.dart';
import 'package:foody/presentation/cubit/bottom_nav_cubit/bottom_nav_cubit.dart';
import 'package:foody/product/mode/product_model.dart';
import 'package:foody/user/model/user_model.dart';
import 'package:intl/intl.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductModel product;
  const ProductDetailScreen({Key? key, required this.product})
      : super(key: key);

  @override
  _ProductDetailWidgetState createState() => _ProductDetailWidgetState();
}

class _ProductDetailWidgetState extends State<ProductDetailScreen> {
  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  UserModel _supplier = UserModel();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.product.ownerId != null) getSupplier();
  }

  getSupplier() async {
    UserModel? user = await FirebaseHelper().getUser(widget.product.ownerId!);
    if (user != null) {
      setState(() {
        _supplier = user;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldMessengerKey,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            IgnorePointer(
              ignoring: isLoading,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                20, 50, 20, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                IconButton(
                                    onPressed: () => Navigator.pop(context),
                                    icon: const Icon(
                                      Icons.arrow_back_rounded,
                                      color: Color(0xFFAB0A4A),
                                      size: 24,
                                    )),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 12, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        widget.product.imageUrl ?? rawImage,
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                24, 12, 24, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  widget.product.name ?? '',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(
                                        fontFamily: 'Lexend Deca',
                                        color: const Color(0xFF090F13),
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ],
                            ),
                          ),
                         /*  Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                24, 4, 24, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  widget.product.location ?? '',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                        fontFamily: 'Lexend Deca',
                                        color: const Color(0xFF8B97A2),
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                      ),
                                ),
                              ],
                            ),
                          ), */
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                24, 16, 24, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Text(
                                    widget.product.description ?? '',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          fontFamily: 'Lexend Deca',
                                          color: const Color(0xFF090F13),
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          /*     Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                24, 24, 24, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Created Date',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                        fontFamily: 'Lexend Deca',
                                        color: const Color(0xFF8B97A2),
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                      ),
                                ),
                                if (widget.product.createAt != null)
                                  Text(
                                    DateFormat("MMM dd, yyyy")
                                        .format(widget.product.createAt!)
                                        .toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2!
                                        .copyWith(
                                          fontFamily: 'Lexend Deca',
                                          color: const Color(0xFF151B1E),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                              ],
                            ),
                          ),
                       */
                          if (widget.product.restaurantName != null)
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  24, 12, 24, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Restaurant Name',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                          fontFamily: 'Lexend Deca',
                                          color: const Color(0xFF8B97A2),
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        ),
                                  ),
                                  Text(
                                    widget.product.restaurantName ?? '',
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2!
                                        .copyWith(
                                          fontFamily: 'Lexend Deca',
                                          color: const Color(0xFF151B1E),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          if (widget.product.location != null)
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  24, 12, 24, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Restaurant Location',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                          fontFamily: 'Lexend Deca',
                                          color: const Color(0xFF8B97A2),
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        ),
                                  ),
                                  Text(
                                    widget.product.location ?? '',
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2!
                                        .copyWith(
                                          fontFamily: 'Lexend Deca',
                                          color: const Color(0xFF151B1E),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                24, 12, 24, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Price',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(
                                        fontFamily: 'Lexend Deca',
                                        color: const Color(0xFF8B97A2),
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal,
                                      ),
                                ),
                                Text(
                                  '$currency ${widget.product.price}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        fontFamily: 'Lexend Deca',
                                        color: const Color(0xFF090F13),
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: StaticColors.appColor,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 4,
                          color: Color(0x55000000),
                          offset: Offset(0, 2),
                        )
                      ],
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0),
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 34),
                      child: TextButton.icon(
                        onPressed: () async {
                          try {
                            setState(() {
                              isLoading = true;
                            });

                            String? mes = await FirebaseHelper().addToCart(
                                widget.product.id!,
                                ownerId: _supplier.id);
                            _scaffoldMessengerKey.currentState
                                ?.showSnackBar(SnackBar(
                              content: Text(mes ?? 'Success'),
                            ));
                            setState(() {
                              isLoading = false;
                            });
                            BlocProvider.of<BottomNavCubit>(context)
                                .resetNavIndex(index: 1);
                            Navigator.pop(context);
                          } catch (e) {
                            setState(() {
                              isLoading = false;
                            });
                            _scaffoldMessengerKey.currentState?.showSnackBar(
                              SnackBar(content: Text(e.toString())),
                            );
                          }
                        },
                        label: Text(
                          'Add to cart',
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    fontFamily: 'Lexend Deca',
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        icon: const Icon(
                          Icons.shopping_cart,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (isLoading)
              Positioned(
                  top: MediaQuery.of(context).size.height / 3,
                  left: MediaQuery.of(context).size.width / 2,
                  child: const Center(child: CircularProgressIndicator()))
          ],
        ),
      ),
    );
  }
}
