import 'package:flutter/material.dart';
import 'package:scancartpro/payment_screen.dart';

class ReceiptScreen extends StatelessWidget {
  final List<String> cartItems;

  const ReceiptScreen({Key? key, required this.cartItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Receipt'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Receipt Details:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            SizedBox(height: 20),
            for (int i = 0; i < cartItems.length; i++)
              ListTile(
                title: Text(cartItems[i]),
                subtitle: Text('Quantity: 1'),
                trailing: Text('\$100.00'),
              ),
            SizedBox(height: 20),
            Divider(
              color: Colors.grey,
              thickness: 2,
            ),
            SizedBox(height: 20),
            Text(
              'Total Amount: \$100.00',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.lightGreen,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              ),
              child: Text(
                'Proceed to Payment',
                style: TextStyle(fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
