import 'package:flutter/material.dart';
import 'package:kelompok/Provider/notification_service.dart';
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
            _buildPaymentOption('https://firebasestorage.googleapis.com/v0/b/kesayangancoffe.firebasestorage.app/o/tunai.png?alt=media&token=0f0e9f06-2f6c-4dad-8552-f545ab8a3b97', 'Tunai', 'tunai'),
            _buildPaymentOption('https://firebasestorage.googleapis.com/v0/b/kesayangancoffe.firebasestorage.app/o/dana.jpg?alt=media&token=796f68a3-9abe-412c-bec5-cbbef2d16f51', 'Dana', 'dana'),
            _buildPaymentOption('https://firebasestorage.googleapis.com/v0/b/kesayangancoffe.firebasestorage.app/o/shopee.png?alt=media&token=bdf253b8-b1ac-4020-a1a0-957733705106', 'Shopeepay', 'shopeepay'),
            _buildPaymentOption('https://firebasestorage.googleapis.com/v0/b/kesayangancoffe.firebasestorage.app/o/gopay.png?alt=media&token=cbb6cf2a-38ec-43b9-90d1-7fdc9cf99bce', 'GoPay', 'gopay'),
            _buildPaymentOption('https://firebasestorage.googleapis.com/v0/b/kesayangancoffe.firebasestorage.app/o/ovo.png?alt=media&token=e44eb3a1-553e-4aeb-9880-ac69976e61a1', 'OVO', 'ovo'),
            ElevatedButton(
              onPressed: () async {
                if (_selectedPaymentMethod != null) {
                  _showLoadingDialog(context);
                  await Future.delayed(Duration(seconds: 2), () async {
                    Provider.of<myProv>(context, listen: false).bnIndex = 1;
                    Provider.of<myProv>(context, listen: false).clearCart();

                    // Tampilkan notifikasi
                    await NotificationService().showNotification(
                      'Pembayaran Berhasil',
                      'Metode pembayaran $_selectedPaymentMethod berhasil digunakan!',
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            'Pembayaran $_selectedPaymentMethod berhasil!'),
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
      leading: Image.network(
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
