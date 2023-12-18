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
  List<String> cartItems = [];
  int quantity = 0;

  @override
  void initState() {
    super.initState();
    cartItems = List.from(widget.cartItems);
  }

  void _removeItem(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  void _increaseQuantity() {
    // Implement your logic to increase the quantity of the item at the given index
    quantity++;
    print("quantity$quantity");
  }

  void _decreaseQuantity(int index) {
    // Implement your logic to decrease the quantity of the item at the given index
  }

  void _generateReceipt() {
    // Implement your logic to generate a receipt based on the cartItems
  }

  void _navigateToReceiptScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReceiptScreen(cartItems: cartItems),
      ),
    );
  }

  void _scanAnotherProduct() {
    Navigator.push(
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
      body: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(cartItems[index]),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () => _decreaseQuantity(index),
                ),
                Text('1'), // Display the quantity or implement dynamic quantity display
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => _increaseQuantity(),
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
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center, // Center the buttons
        children: [
          FloatingActionButton(
            onPressed: _scanAnotherProduct,
            child: Icon(Icons.add),
          ),
          SizedBox(width: 16), // Add some space between the FloatingActionButtons
          FloatingActionButton(
            onPressed: () {
              _generateReceipt();
              _navigateToReceiptScreen();
            },
            child: Icon(Icons.receipt),
          ),
        ],
      ),
    );
  }
}
