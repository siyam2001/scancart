import 'package:flutter/material.dart';
import 'package:scancartpro/product_scanner_screen.dart';
import 'package:scancartpro/receipt_screen.dart';

class CartScreen extends StatefulWidget {
  final List<String> cartItems;

  const CartScreen({Key? key, required this.cartItems}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Map<String, dynamic>> cartItems = [];
  int quantity = 1;

  @override
  void initState() {
    super.initState();
    cartItems = widget.cartItems.map((item) => {'name': item, 'quantity': 1}).toList();
  }

  void _removeItem(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  void _updateQuantity(int index, bool isIncrement) {
    setState(() {
      if (isIncrement) {
        cartItems[index]['quantity']++;
      } else {
        if (cartItems[index]['quantity'] > 1) {
          cartItems[index]['quantity']--;
        }
      }
    });
  }

  void _generateReceipt() {
    if (cartItems.isEmpty) {
      // Show a button to scan new products
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Cart is Empty'),
          content: Column(
            children: [
              Text('Add products to your cart by scanning them.'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Navigate to the product scanner screen
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductScannerScreen(),
                    ),
                  );
                },
                child: Text('Scan New Products'),
              ),
            ],
          ),
        ),
      );
    } else {
      // Navigate to the ReceiptScreen with the cart items
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ReceiptScreen(cartItems: cartItems.map((item) => item['name'] as String).toList()),
        ),
      );
    }
  }

  void _navigateToProductScannerScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ProductScannerScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart'),
      ),
      body: cartItems.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Your cart is empty.'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _navigateToProductScannerScreen(),
              child: Text('Scan New Products'),
            ),
          ],
        ),
      )
          : ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(cartItems[index]['name']),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () => _updateQuantity(index, false),
                ),
                Text('${cartItems[index]['quantity']}'),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => _updateQuantity(index, true),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _removeItem(index),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: cartItems.isEmpty
          ? null
          : Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: () => _navigateToProductScannerScreen(),
            child: Icon(Icons.add),
          ),
          SizedBox(width: 16),
          FloatingActionButton(
            onPressed: () {
              _generateReceipt();
            },
            child: Icon(Icons.receipt),
          ),
        ],
      ),
    );
  }
}
