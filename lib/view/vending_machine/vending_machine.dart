import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:vending_machine/common/image_assets.dart';
import 'package:vending_machine/model/snack.dart';
import 'package:vending_machine/view/vending_machine/widgets/bottom_sheet_payment.dart';
import 'package:vending_machine/view/vending_machine/widgets/product_card.dart';
import 'package:vending_machine/view/vending_machine/widgets/snackbars.dart';

class VendingMachine extends StatefulWidget {
  const VendingMachine({Key? key}) : super(key: key);

  @override
  State<VendingMachine> createState() => _VendingMachineState();
}

class _VendingMachineState extends State<VendingMachine> {
  late List<Snack> products;

  @override
  void initState() {
    super.initState();
    products = [
      Cookies(price: 6000, stock: 10, thumbnail: ImageAssets.cookies),
      Chips(price: 8000, stock: 10, thumbnail: ImageAssets.chips),
      Oreo(price: 10000, stock: 10, thumbnail: ImageAssets.oreo),
      Tango(price: 12000, stock: 10, thumbnail: ImageAssets.tango),
      ChocolateBar(
        price: 15000,
        stock: 10,
        thumbnail: ImageAssets.chocolateBar,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
        title: const Text('Vending Machine'),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products.elementAt(index);
                return ProductCard(
                  product: product,
                  onTap: () {
                    if (product.stock == 0) {
                      SnackBars.show(context, message: 'No Stock! Sorrry!', isPositive: false, behavior: FlashBehavior.fixed);
                    } else {
                      showBottomSheetPayment(
                        context,
                        product: product,
                        onConfirmation: (cashType) {
                          Navigator.pop(context);

                          setState(() {
                            products = products.map(
                              (e) {
                                if (e.name == product.name) {
                                  return e.copyWith(stock: e.stock - 1);
                                }
                                return e;
                              },
                            ).toList();
                          });
                          if (cashType > product.price) {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                content: Text(
                                    'Your change is Rp${cashType - product.price}'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      'Confirm',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  )
                                ],
                              ),
                            );
                          }
                        },
                      );
                    }
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
