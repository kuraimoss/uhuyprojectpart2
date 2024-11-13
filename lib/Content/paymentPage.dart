import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Activity/dashboard.dart';
import '../Provider/provider.dart';

class paymentPage extends StatefulWidget {
  @override
  _paymentPageState createState() => _paymentPageState();
}

class _paymentPageState extends State<paymentPage> {
  String? _selectedPaymentMethod;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                width: 50,
                height: 3,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(2.5),
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Pilih Metode Pembayaran',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Divider(thickness: 1.5),
            _buildPaymentOption('assets/tunai.png', 'Tunai', 'tunai'),
            _buildPaymentOption('assets/dana.jpg', 'Dana', 'dana'),
            _buildPaymentOption('assets/shopee.png', 'Shopeepay', 'shopeepay'),
            _buildPaymentOption('assets/gopay.png', 'GoPay', 'gopay'),
            _buildPaymentOption('assets/ovo.png', 'OVO', 'ovo'),
            ElevatedButton(
              onPressed: () {
                if (_selectedPaymentMethod != null) {
                  _showLoadingDialog(context);
                  Future.delayed(Duration(seconds: 2), () {
                    Provider.of<myProv>(context, listen: false).bnIndex = 1;
                    Provider.of<myProv>(context, listen: false).clearCart();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Pembayaran $_selectedPaymentMethod berhasil!'),
                      ),
                    );
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => myHome()),
                      (route) => false,
                    );
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Pilih metode pembayaran terlebih dahulu!'),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15),
                textStyle: TextStyle(fontSize: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Center(
                child: Text('Bayar Sekarang'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOption(String imagePath, String title, String value) {
    return ListTile(
      leading: Image.asset(
        imagePath,
        width: 40,
        height: 40,
      ),
      title: Text(title),
      trailing: Radio<String>(
        value: value,
        groupValue: _selectedPaymentMethod,
        onChanged: (String? newValue) {
          setState(() {
            _selectedPaymentMethod = newValue;
          });
        },
      ),
    );
  }

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 20),
                Text("Memproses pembayaran..."),
              ],
            ),
          ),
        );
      },
    );
  }
}
