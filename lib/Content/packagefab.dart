import 'package:flutter/material.dart';

class packageFab extends StatefulWidget {
  const packageFab({Key? key}) : super(key: key);

  @override
  State<packageFab> createState() => _packageFabState();
}

class _packageFabState extends State<packageFab> {
  bool isExpandedCaraPakai = false;
  bool isExpandedSyaratKetentuan = false;
  int selectedIndex = 0; 

  final List<Map<String, String>> packages = [
    {
      'title': 'Monthly Package',
      'duration': '30 hari',
      'saving': 'Rp 60.000',
      'benefit': 'Potongan belanja Rp 15000',
      'price': 'Rp. 50.000'
    },
    {
      'title': 'Weekly Package',
      'duration': '7 hari',
      'saving': 'Rp 20.000',
      'benefit': 'Potongan belanja Rp 5000',
      'price': 'Rp. 20.000'
    },
    {
      'title': 'Daily Package',
      'duration': '1 hari',
      'saving': 'Rp 5.000',
      'benefit': 'Potongan belanja Rp 1000',
      'price': 'Rp. 5.000'
    },
  ];

  Widget buildPackage(Map<String, String> package, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index; 
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        decoration: BoxDecoration(
          color: selectedIndex == index ? Color(0xFFd3e3e1) : Colors.white, 
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    package['title']!,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFd9d9d9),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: 'Hemat Hingga ',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: package['saving']!,
                            style: TextStyle(
                              color: Color(0xFF107d72),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Keuntungan: ${package['benefit']}',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Min. Transaksi: Rp 40.000',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    'Penggunaan: 1x Per hari',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    'Masa Berlaku: ${package['duration']}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Divider(color: Colors.grey),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isExpandedCaraPakai = !isExpandedCaraPakai;
                        isExpandedSyaratKetentuan = false;
                      });
                    },
                    child: Row(
                      children: [
                        Text(
                          'Cara Pakai Voucher',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(
                          isExpandedCaraPakai
                              ? Icons.arrow_drop_down
                              : Icons.arrow_right,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isExpandedSyaratKetentuan = !isExpandedSyaratKetentuan;
                        isExpandedCaraPakai = false;
                      });
                    },
                    child: Row(
                      children: [
                        Text(
                          'Syarat & Ketentuan',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(
                          isExpandedSyaratKetentuan
                              ? Icons.arrow_drop_down
                              : Icons.arrow_right,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (isExpandedCaraPakai)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Teks untuk cara pakai voucher yang panjang...',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.black,
                  ),
                ),
              ),
            if (isExpandedSyaratKetentuan)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Teks untuk syarat & ketentuan yang panjang...',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.black,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF107d72),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Kura Coffee Package',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: packages.length,
        itemBuilder: (context, index) {
          return buildPackage(packages[index], index);
        },
      ),
      bottomNavigationBar: Container(
        height: 65,
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 50),
        child: ElevatedButton(
          onPressed: () {
          
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              Color(0xFF107d72),
            ),
            foregroundColor: MaterialStateProperty.all<Color>(
              Colors.white,
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
          ),
          child: Text('Beli Paket - ${packages[selectedIndex]['price']}'), 
        ),
      ),
    );
  }
}
