import 'package:flutter/material.dart';
import 'package:scancartpro/product_scanner_screen.dart';

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Your logo image here
            Image.asset('assets/fyp_logo.jpeg', height: 100, width: 100),
            SizedBox(height: 20),
            Text(
              'Get Started',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProductScannerScreen()),
                );
              },
              child: Text('Scan a Product'),
            ),
          ],
        ),
      ),
    );
  }
}
