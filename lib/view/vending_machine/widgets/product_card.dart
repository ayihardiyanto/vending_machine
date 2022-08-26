import 'package:flutter/material.dart';
import 'package:vending_machine/model/snack.dart';

class ProductCard extends StatelessWidget {
  final Snack product;
  final VoidCallback? onTap;
  const ProductCard({Key? key, required this.product, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onTap,
        child: Ink(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: product.stock == 0 ? Colors.grey : Colors.white,
              boxShadow: const [
                BoxShadow(
                  blurRadius: 5,
                  color: Color.fromRGBO(155, 155, 155, 0.1),
                  spreadRadius: 0,
                  offset: Offset(0, 1),
                )
              ],
              borderRadius: BorderRadius.circular(10)),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    product.thumbnail,
                    height: 120,
                    width: 120,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Rp${product.price.toStringAsFixed(0)}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  decoration:  BoxDecoration(
                    shape: BoxShape.circle,
                    color: product.stock == 0 ? Colors.red : Colors.green,
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    product.stock.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
