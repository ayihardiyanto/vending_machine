import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:vending_machine/model/snack.dart';
import 'package:vending_machine/view/vending_machine/widgets/snackbars.dart';

Future<void> showBottomSheetPayment(BuildContext context,
    {Function(int cashType)? onConfirmation, required Snack product}) {
  return showModalBottomSheet(
      context: context,
      builder: (context) {
        return PaymentContent(
          onConfirmation: onConfirmation,
          product: product,
        );
      });
}

class PaymentContent extends StatefulWidget {
  final Function(int cashType)? onConfirmation;
  final Snack product;
  const PaymentContent({Key? key, this.onConfirmation, required this.product})
      : super(key: key);

  @override
  State<PaymentContent> createState() => _PaymentContentState();
}

class _PaymentContentState extends State<PaymentContent> {
  int totalCashPaid = 0;
  @override
  Widget build(BuildContext context) {
    List<int> cashTypes = [
      2000,
      5000,
      10000,
      50000,
      100000,
    ];
    List<Color> colors = [
      Colors.grey[100]!,
      Colors.yellow[200]!,
      Colors.red[100]!,
      Colors.blue,
      Colors.red[200]!,
    ];
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GridView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 4.0,
          ),
          itemCount: cashTypes.length,
          itemBuilder: (context, index) {
            final cashType = cashTypes.elementAt(index);
            return Material(
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () {
                  setState(() {
                    totalCashPaid += cashType;
                  });
                },
                child: Ink(
                  padding: const EdgeInsets.all(8),
                  height: 100,
                  decoration: BoxDecoration(
                    color: colors.elementAt(index),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 5,
                        color: Color.fromRGBO(155, 155, 155, 0.1),
                        spreadRadius: 0,
                        offset: Offset(0, 1),
                      )
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'Rp$cashType',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text('Total Cash Rp$totalCashPaid'),
        ),
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Row(
            children: [
              Expanded(
                child: TextButton(
                  style: ButtonStyle(
                    padding:
                        MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    SnackBars.show(
                      context,
                      message: 'Purchase cancelled',
                      isPositive: false,
                      behavior: FlashBehavior.fixed,
                    );
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    if (widget.product.price > totalCashPaid) {
                      SnackBars.show(
                        context,
                        message:
                            'Unsufficient amount of money, please insert more.',
                        isPositive: false,
                        behavior: FlashBehavior.fixed,
                      );
                    }
                    else{
                      widget.onConfirmation?.call(totalCashPaid);
                    }
                  },
                  child: const Text('Confirm'),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 50,
        )
      ],
    );
  }
}
