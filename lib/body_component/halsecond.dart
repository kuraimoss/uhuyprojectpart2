import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flat_banners/flat_banners.dart';

import '../Content/message.dart';
import '../Content/packagefab.dart';
import '../Provider/provider.dart';

class HalSecond extends StatefulWidget {
  const HalSecond({Key? key}) : super(key: key);

  @override
  State<HalSecond> createState() => _HalSecondState();
}

class _HalSecondState extends State<HalSecond> {
  final List<String> imagePaths = [
    'assets/home1.jpg',
    'assets/home2.jpg',
    'assets/home3.jpg',
    'assets/home2.jpg',
  ];

  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
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
                left: 16.0,
                bottom: 80.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Selamat Siang',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'kuraashop',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 20.0,
                bottom: 100.0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NotifikasiPage()),
                    );
                  },
                  child: ClipOval(
                    child: Container(
                      width: 40,
                      height: 40,
                      child: Image.asset(
                        'assets/lonceng.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 20,
                right: 20,
                bottom: 10,
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: 20),
                      ClipOval(
                        child: Image.asset(
                          'assets/profil.jpg',
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        '8 Point',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF08611b),
                        ),
                      ),
                      SizedBox(width: 140),
                      Image.asset(
                        'assets/koin.png',
                        width: 55,
                        height: 25,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Consumer<myProv>(
              builder: (context, provider, child) {
                if (provider.showBanner) {
                  return Stack(
                    children: [
                      FlatBanners(
                        imageWidth: 80,
                        gradientColors: [
                          const Color(0xFF107d72).withOpacity(0.9),
                          const Color(0xFFa1f0b3).withOpacity(0.8),
                        ],
                        title: 'Special Offer',
                        subtitle: 'Package Bundling!',
                        btnText: 'GO TO',
                        actionBtnBgColor: Color(0xFF107d72),
                        image: 'assets/banner.png',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => packageFab()),
                          );
                        },
                      ),
                      Positioned(
                        right: 1.0,
                        child: IconButton(
                          icon: Icon(Icons.close, color: Colors.black),
                          onPressed: () {
                            provider.setShowBanner(false);
                          },
                        ),
                      ),
                    ],
                  );
                } else {
                  return Container();
                }
              },
            ),
            Container(
              height: 200,
              child: PageView.builder(
                controller: _pageController,
                itemCount: imagePaths.length,
                itemBuilder: (context, index) {
                  return Center(
                    child: Image.asset(
                      imagePaths[index],
                      width: 350,
                      height: 170,
                      fit: BoxFit.cover,
                    ),
                  );
                },
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
              ),
            ),
            _buildPageIndicator(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    'Pesan Sekarang',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      height: 100,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFFa1f0b3), Colors.white],
                          stops: [0.0, 0.6],
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                        ),
                        border: Border.all(
                          color: Color(0xFF107d72),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Pick Up',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF107d72),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 7,
                                child: Text(
                                  'Ambil di store tanpa antri',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Icon(Icons.store),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Container(
                      height: 100,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFFffcb8c), Colors.white],
                          stops: [0.0, 0.6],
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                        ),
                        border: Border.all(
                          color: Color(0xFFc26823),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Delivery',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFc26823),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 7,
                                child: Text(
                                  'Pesanan antar ke lokasimu',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Icon(Icons.delivery_dining),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Container(
              height: 100,
              width: 350,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 2, color: Color(0xFFc7c7c7)),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Positioned(
                    left: 10,
                    bottom: 20,
                    child: Icon(
                      Icons.coffee_outlined,
                      size: 80,
                      color: Colors.black,
                    ),
                  ),
                  Positioned(
                    left: 25,
                    bottom: 3,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF107d72),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        '20%',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 120,
                    bottom: 10,
                    child: Container(
                      height: 73,
                      width: 3,
                      color: Color(0xFFd9d9d9),
                    ),
                  ),
                  Positioned(
                    left: 140,
                    bottom: 50,
                    child: Text(
                      'Diskon 50%',
                      style: TextStyle(
                        color: Color(0xFF107d72),
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 140,
                    bottom: 20,
                    child: Container(
                      width: 200,
                      child: Text(
                        'Yuk, ajak teman kamu\ndownload aplikasi Kura Shop',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(
        imagePaths.length,
        (int index) {
          return AnimatedContainer(
            duration: Duration(milliseconds: 300),
            height: 8,
            width: (index == _currentPage) ? 24 : 8,
            margin: EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              color: (index == _currentPage)
                  ? Color(0xFF08611b)
                  : Color(0xFF8ca69d),
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
          );
        },
      ),
    );
  }
}
