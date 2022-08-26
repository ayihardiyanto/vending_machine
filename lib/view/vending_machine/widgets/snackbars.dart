import 'package:flash/flash.dart';
import 'package:flutter/material.dart';

class SnackBars {
  static Future<void> show(
    context, {
    required String message,
    required bool isPositive,
    Duration duration = const Duration(seconds: 3),
    FlashBehavior behavior = FlashBehavior.floating,
    FlashPosition position = FlashPosition.bottom,
  }) {
    return showFlash(
      context: context,
      duration: duration,
      builder: (context, controller) => Flash(
        controller: controller,
        position: position,
        backgroundColor: isPositive ? Colors.green : Colors.red,
        behavior: behavior,
        child: FlashBar(
          content: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                isPositive ? Icons.check_circle : Icons.error,
                size: 20,
                color: Colors.white,
              ),
              const SizedBox(width: 12,),
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(color: Colors.white,),
                  overflow: TextOverflow.visible,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}