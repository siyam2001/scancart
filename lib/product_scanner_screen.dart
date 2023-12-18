import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:camera/camera.dart';
import 'package:scancartpro/cart_screen.dart';

class ProductScannerScreen extends StatefulWidget {
  @override
  _ProductScannerScreenState createState() => _ProductScannerScreenState();
}

class _ProductScannerScreenState extends State<ProductScannerScreen> {
  String scannedCode = 'Scan a product';
  late CameraController _cameraController;
  bool _isCameraInitialized = false;
  List<Map<String, dynamic>> cartItems = [];

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      final firstCamera = cameras.first;

      _cameraController = CameraController(
        firstCamera,
        ResolutionPreset.medium,
      );

      await _cameraController.initialize();
      setState(() {
        _isCameraInitialized = true;
      });
    } catch (e) {
      print('Error initializing camera: $e');
    }
  }

  Future<void> _disposeCamera() async {
    await _cameraController.dispose();
  }

  Future<void> scanProduct() async {
    try {
      if (!_isCameraInitialized) {
        print('Camera not initialized');
        return;
      }

      await _cameraController.startImageStream((CameraImage image) {
        print('Processing camera image...');
      });

      String result = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.DEFAULT,
      );

      if (!mounted) return;

      setState(() {
        Map<String, dynamic> scannedProduct = {
          'name': result,
          'quantity': 1,
        };

        if (cartItems.isEmpty) {
          cartItems.add(scannedProduct);
        } else {
          cartItems.insert(1, scannedProduct);
        }
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CartScreen(cartItems: cartItems.map((item) => item['name'] as String).toList()),
        ),
      );
    } catch (e) {
      setState(() {
        scannedCode = 'Error: $e';
      });
    }
  }

  @override
  void dispose() {
    _disposeCamera();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Scanner'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      CartScreen(cartItems: cartItems.map((item) => item['name'] as String).toList()),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: _isCameraInitialized
                ? Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: CameraPreview(_cameraController),
            )
                : Container(),
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: scanProduct,
            child: Text('Scan Product'),
          ),
          SizedBox(height: 20.0),
          Text(
            'Scanned Code: $scannedCode',
            style: TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}
