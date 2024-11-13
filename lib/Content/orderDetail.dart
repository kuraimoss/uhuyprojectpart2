import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/cart_item.dart';
import '../Provider/provider.dart';
import 'paymentPage.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<myProv>(context);
    final List<CartItem> _orderItems = cartProvider.cartItems;

    int totalHarga = 0;
    _orderItems.forEach((item) {
      int itemPrice = item.price;

      if (item.syrup == 'Aren' || item.syrup == 'Vanilla') {
        itemPrice += 5000;
      }

      if (item.size == 'Large') {
        itemPrice += 5000;
      }

      totalHarga += itemPrice * item.quantity;
    });

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Order Details'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                height: 60,
                decoration: BoxDecoration(
                  color: Color(0xFFd9d9d9),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TabBar(
                  labelColor: Colors.black,
                  indicator: BoxDecoration(
                    color: Color(0xFF107d72),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  tabs: [
                    Tab(
                      icon: Icon(Icons.delivery_dining),
                      text: 'Delivery',
                    ),
                    Tab(
                      icon: Icon(Icons.storefront),
                      text: 'Pick Up',
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    DeliveryPage(
                        orderItems: _orderItems, totalHarga: totalHarga),
                    PickupPage(orderItems: _orderItems, totalHarga: totalHarga),
                  ],
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class DeliveryPage extends StatelessWidget {
  final List<CartItem> orderItems;
  final int totalHarga;

  const DeliveryPage(
      {Key? key, required this.orderItems, required this.totalHarga})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Daftar Pesanan',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: orderItems.length,
              itemBuilder: (context, index) {
                final item = orderItems[index];
                int itemPrice = item.price;

                if (item.syrup == 'Aren' || item.syrup == 'Vanilla') {
                  itemPrice += 5000;
                }

                if (item.size == 'Large') {
                  itemPrice += 5000;
                }

                return _buildOrderItem(context, item, itemPrice);
              },
            ),
          ),
          Row(
            children: [
              Text(
                'Ringkasan Pembayaran',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
              ),
              IconButton(
                icon: Icon(Icons.info_outline),
                iconSize: 17,
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                              'Ringkasan Pembayaran',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Divider(thickness: 1.5),
                            SizedBox(height: 10),
                            Text(
                              'Instruksi Pembayaran: ',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text('1. Pilih metode pembayaran yang diinginkan.'),
                            Text('2. Klik tombol "Konfirmasi".'),
                            Text(
                                '3. Ikuti petunjuk lebih lanjut sesuai dengan metode pembayaran yang dipilih.'),
                            SizedBox(height: 10),
                            Text(
                              'Catatan:',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(
                                '1. Pastikan untuk memeriksa ulang informasi pembayaran sebelum melakukan transaksi.'),
                            Text(
                                '2. Simpan bukti pembayaran untuk referensi di masa depan.'),
                            SizedBox(height: 10),
                            Text(
                              'Bantuan:',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(
                                'Jika mengalami kesulitan atau ada pertanyaan, hubungi layanan pelanggan kami di 123-456-789 atau email support@kura.com.'),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              Text(
                'Rp $totalHarga',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return paymentPage();
                },
              );
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 15),
              textStyle: TextStyle(fontSize: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Center(
              child: Text('Pembayaran'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderItem(BuildContext context, CartItem item, int itemPrice) {
    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage('assets/machiato.jpg'),
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  'Size: ${item.size}, Ice: ${item.iceLevel}, Syrup: ${item.syrup}',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                Text(
                  'Rp ${itemPrice * item.quantity}',
                  style: TextStyle(fontSize: 18),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        if (item.quantity > 1) {
                          Provider.of<myProv>(context, listen: false)
                              .updateCartItemQuantity(item, item.quantity - 1);
                        }
                      },
                    ),
                    Text(item.quantity.toString()),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        Provider.of<myProv>(context, listen: false)
                            .updateCartItemQuantity(item, item.quantity + 1);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        Provider.of<myProv>(context, listen: false)
                            .removeFromCart(item);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PickupPage extends StatelessWidget {
  final List<CartItem> orderItems;
  final int totalHarga;

  const PickupPage(
      {Key? key, required this.orderItems, required this.totalHarga})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Daftar Pesanan',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: orderItems.length,
              itemBuilder: (context, index) {
                final item = orderItems[index];
                int itemPrice = item.price;

                if (item.syrup == 'Aren' || item.syrup == 'Vanilla') {
                  itemPrice += 5000;
                }

                if (item.size == 'Large') {
                  itemPrice += 5000;
                }

                return _buildOrderItem(context, item, itemPrice);
              },
            ),
          ),
          Row(
            children: [
              Text(
                'Ringkasan Pembayaran',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
              ),
              IconButton(
                icon: Icon(Icons.info_outline),
                iconSize: 17,
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                              'Ringkasan Pembayaran',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Divider(thickness: 1.5),
                            SizedBox(height: 10),
                            Text(
                              'Instruksi Pembayaran: ',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text('1. Pilih metode pembayaran yang diinginkan.'),
                            Text('2. Klik tombol "Konfirmasi".'),
                            Text(
                                '3. Ikuti petunjuk lebih lanjut sesuai dengan metode pembayaran yang dipilih.'),
                            SizedBox(height: 10),
                            Text(
                              'Catatan:',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(
                                '1. Pastikan untuk memeriksa ulang informasi pembayaran sebelum melakukan transaksi.'),
                            Text(
                                '2. Simpan bukti pembayaran untuk referensi di masa depan.'),
                            SizedBox(height: 10),
                            Text(
                              'Bantuan:',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(
                                'Jika mengalami kesulitan atau ada pertanyaan, hubungi layanan pelanggan kami di 123-456-789 atau email support@kura.com.'),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              Text(
                'Rp $totalHarga',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return paymentPage();
                },
              );
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 15),
              textStyle: TextStyle(fontSize: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Center(
              child: Text('Pembayaran'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderItem(BuildContext context, CartItem item, int itemPrice) {
    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage('assets/machiato.jpg'),
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  'Size: ${item.size}, Ice: ${item.iceLevel}, Syrup: ${item.syrup}',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                Text(
                  'Rp ${itemPrice * item.quantity}',
                  style: TextStyle(fontSize: 18),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        if (item.quantity > 1) {
                          Provider.of<myProv>(context, listen: false)
                              .updateCartItemQuantity(item, item.quantity - 1);
                        }
                      },
                    ),
                    Text(item.quantity.toString()),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        Provider.of<myProv>(context, listen: false)
                            .updateCartItemQuantity(item, item.quantity + 1);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        Provider.of<myProv>(context, listen: false)
                            .removeFromCart(item);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
