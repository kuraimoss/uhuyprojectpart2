import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Activity/dashboard.dart';
import '../Content/bantuanPage.dart';
import '../Provider/provider.dart';

class PesananPage extends StatefulWidget {
  const PesananPage({Key? key}) : super(key: key);

  @override
  State<PesananPage> createState() => _PesananPageState();
}

class _PesananPageState extends State<PesananPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedStatus = 'Proses';
  String _selectedChip = 'Proses';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _setStatus(String status) {
    setState(() {
      _selectedStatus = status;
      _selectedChip = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                'assets/home.jpg',
                fit: BoxFit.cover,
              ),
              Positioned(
                left: 20,
                right: 20,
                bottom: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pesanan',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    ),
                    SizedBox(height: 8),
                    TabBar(
                      controller: _tabController,
                      tabs: [
                        Tab(text: 'Pickup'),
                        Tab(text: 'Delivery'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(2.0),
            child: Container(
              color: Colors.white,
              height: 2.0,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 10),
                _buildChip('Proses'),
                SizedBox(width: 10),
                _buildChip('Selesai'),
                SizedBox(width: 10),
                _buildChip('Dibatalkan'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildPesananTab('Pick Up'),
                _buildPesananTab('Delivery'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChip(String status) {
    return ActionChip(
      label: Text(
        status,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 13,
          color: _selectedChip == status ? Colors.white : Colors.black,
        ),
      ),
      backgroundColor:
          _selectedChip == status ? Color(0xFF107d72) : Colors.grey[300],
      onPressed: () {
        _setStatus(status);
      },
    );
  }

  Widget _buildPesananTab(String type) {
    List<Map<String, String>> pesananList = [
      {
        'imagePath': 'assets/machiato.jpg',
        'title': 'American Coffee, Ekspresso',
        'quantity': '2 Item',
        'price': 'Rp. 50.000',
        'dateTime': '08/1/2024 21.00',
        'prosesText': 'Proses',
        'statusText': 'Pick Up',
      },
      {
        'imagePath': 'assets/machiato.jpg',
        'title': 'American Coffee, Ekspresso',
        'quantity': '2 Item',
        'price': 'Rp. 50.000',
        'dateTime': '08/1/2024 21.00',
        'prosesText': 'Selesai',
        'statusText': 'Pick Up',
      },
      {
        'imagePath': 'assets/machiato.jpg',
        'title': 'American Coffee, Ekspresso',
        'quantity': '2 Item',
        'price': 'Rp. 50.000',
        'dateTime': '08/1/2024 21.00',
        'prosesText': 'Dibatalkan',
        'statusText': 'Pick Up',
      },
      {
        'imagePath': 'assets/machiato.jpg',
        'title': 'American Coffee, Ekspresso',
        'quantity': '2 Item',
        'price': 'Rp. 50.000',
        'dateTime': '08/1/2024 21.00',
        'prosesText': 'Proses',
        'statusText': 'Delivery',
      },
      {
        'imagePath': 'assets/machiato.jpg',
        'title': 'American Coffee, Ekspresso',
        'quantity': '2 Item',
        'price': 'Rp. 50.000',
        'dateTime': '08/1/2024 21.00',
        'prosesText': 'Selesai',
        'statusText': 'Delivery',
      },
      {
        'imagePath': 'assets/machiato.jpg',
        'title': 'American Coffee, Ekspresso',
        'quantity': '2 Item',
        'price': 'Rp. 50.000',
        'dateTime': '08/1/2024 21.00',
        'prosesText': 'Dibatalkan',
        'statusText': 'Delivery',
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: pesananList
            .where((item) =>
                item['prosesText'] == _selectedStatus &&
                item['statusText'] == type)
            .map((item) => Column(
                  children: [
                    _buildPesananItem(
                      item['imagePath']!,
                      item['title']!,
                      item['quantity']!,
                      item['price']!,
                      item['dateTime']!,
                      item['prosesText']!,
                      item['statusText']!,
                      _getStatusColor(item['prosesText']!),
                    ),
                    Divider(color: Colors.grey),
                  ],
                ))
            .toList(),
      ),
    );
  }

  Color _getStatusColor(String prosesText) {
    switch (prosesText) {
      case 'Proses':
        return Colors.orange;
      case 'Selesai':
        return Colors.green;
      case 'Dibatalkan':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Widget _buildPesananItem(
    String imagePath,
    String title,
    String quantity,
    String price,
    String dateTime,
    String prosesText,
    String statusText,
    Color statusColor,
  ) {
    IconData iconData;
    switch (prosesText) {
      case 'Selesai':
        iconData = Icons.check_circle;
        break;
      case 'Dibatalkan':
        iconData = Icons.cancel;
        break;
      default:
        iconData = Icons.check_circle;
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                imagePath,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 11,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    quantity,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        iconData,
                        color: Colors.black,
                        size: 13,
                      ),
                      SizedBox(width: 4),
                      Text(
                        prosesText,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: statusColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        SizedBox(width: 4),
                        Text(
                          statusText,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    price,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  PopupMenuButton<String>(
                    onSelected: (String value) {
                      switch (value) {
                        case 'Beli Kembali':
                          Provider.of<myProv>(context, listen: false).bnIndex =
                              1;
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => myHome()),
                          );
                          break;
                        case 'Tambah ke Wishlist':
                          Provider.of<myProv>(context, listen: false)
                              .addToWishlist('2');
                          break;
                        case 'Bantuan':
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BantuanPage()),
                          );
                          break;
                      }
                    },
                    itemBuilder: (BuildContext context) {
                      return {'Beli Kembali', 'Tambah ke Wishlist', 'Bantuan'}
                          .map((String choice) {
                        return PopupMenuItem<String>(
                          value: choice,
                          child: Text(choice),
                        );
                      }).toList();
                    },
                  ),
                ],
              ),
              SizedBox(height: 40),
              Text(
                dateTime,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
