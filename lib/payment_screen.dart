import 'package:flutter/material.dart';
import 'package:scancartpro/payment_success_screen.dart';

class PaymentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Payment'),

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ... (existing code)

            ElevatedButton(
              onPressed: () async {
                // Simulate a delay to simulate payment processing
                await Future.delayed(Duration(seconds: 1));

                // Navigate to the payment success screen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentSuccessScreen(),
                  ),
                );
              },
              child: Text('Make Payment'),
            ),
          ],
        ),
      ),
    );
  }
}
