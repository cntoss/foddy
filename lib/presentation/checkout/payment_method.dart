import 'package:flutter/material.dart';
import 'package:foody/presentation/checkout/confirmation_screen.dart';

import '../../product/mode/product_model.dart';

class PaymentMethodScreen extends StatefulWidget {
  final List<ProductModel> products;
  const PaymentMethodScreen({super.key, required this.products});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  String selectedMethod = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: SizedBox(), title: Text('Payment Method')),
      body: Container(
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            )),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Select payment method to continue'),
          Row(
            children: [
              Checkbox(
                  value: selectedMethod == 'cod',
                  onChanged: (bool? val) {
                    if (val ?? false) {
                      setState(() {
                        selectedMethod = 'cod';
                      });
                    } else {
                      setState(() {
                        selectedMethod = '';
                      });
                    }
                  }),
              Text('Cash On Delivery')
            ],
          ),
          Row(
            children: [
              Checkbox(
                  value: selectedMethod == 'card',
                  onChanged: (bool? val) {
                    if (val ?? false) {
                      setState(() {
                        selectedMethod = 'card';
                      });
                    } else {
                      setState(() {
                        selectedMethod = '';
                      });
                    }
                  }),
              Text('Card Payment')
            ],
          ),
          Row(
            children: [
              Checkbox(
                  value: selectedMethod == 'wallet',
                  onChanged: (bool? val) {
                    if (val ?? false) {
                      setState(() {
                        selectedMethod = 'wallet';
                      });
                    } else {
                      setState(() {
                        selectedMethod = '';
                      });
                    }
                  }),
              const Text('Wallet Payment')
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 3,
          ),
          Center(
              child: ElevatedButton(
                  onPressed: () {
                    if (selectedMethod != '') {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ConfirmationScreen(
                                    methodname: selectedMethod == 'cod'
                                        ? 'Cash On Delivery'
                                        : selectedMethod == 'wallet'
                                            ? 'Wallet Payment'
                                            : 'Card Payment',
                                    products: widget.products,
                                  )));
                    }
                  },
                  child: const Text('Continue')))
        ]),
      ),
    );
  }
}
