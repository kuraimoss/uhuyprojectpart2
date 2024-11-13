import 'package:flutter/material.dart';

class BantuanPage extends StatelessWidget {
  const BantuanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bantuan'),
        backgroundColor: Color(0xFF107d72),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.help_outline, color: Color(0xFF107d72)),
              title: Text('Cara Pesan'),
              subtitle: Text('Pelajari cara memesan produk kami.'),
              onTap: () {},
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.payment, color: Color(0xFF107d72)),
              title: Text('Metode Pembayaran'),
              subtitle:
                  Text('Informasi tentang metode pembayaran yang tersedia.'),
              onTap: () {},
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.delivery_dining, color: Color(0xFF107d72)),
              title: Text('Pengiriman'),
              subtitle:
                  Text('Detail tentang opsi pengiriman dan waktu pengiriman.'),
              onTap: () {},
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.policy, color: Color(0xFF107d72)),
              title: Text('Kebijakan Pengembalian'),
              subtitle: Text('Ketahui kebijakan pengembalian kami.'),
              onTap: () {},
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.contact_support, color: Color(0xFF107d72)),
              title: Text('Hubungi Kami'),
              subtitle: Text('Cara menghubungi tim dukungan kami.'),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
