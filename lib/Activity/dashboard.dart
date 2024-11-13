import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider/provider.dart';
import '../body_component/halsecond.dart';
import '../body_component/menu.dart';
import '../body_component/pesanan.dart';
import '../body_component/profile.dart';

class myHome extends StatefulWidget {
  const myHome({super.key});

  @override
  State<myHome> createState() => _myHomeState();
}

class _myHomeState extends State<myHome> {
  final List<Widget> _body = [
    HalSecond(),
    MyMenu(),
    PesananPage(),
    MyProfile()
  ];
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<myProv>(context, listen: false);
    _pageController = PageController(initialPage: provider.bnIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<myProv>(context);
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: provider.bnIndex,
        selectedItemColor: Color(0xFF107d72),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: (value) {
          provider.bnIndex = value;
          _pageController.animateToPage(value,
              duration: Duration(milliseconds: 500), curve: Curves.ease);
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.restaurant_menu), label: "Menu"),
          BottomNavigationBarItem(
              icon: Icon(Icons.date_range_sharp), label: "Pesanan"),
          BottomNavigationBarItem(icon: Icon(Icons.person_2), label: "Profile"),
        ],
        unselectedLabelStyle: TextStyle(color: Colors.grey),
      ),
      body: PageView(
        children: _body,
        controller: _pageController,
        onPageChanged: (value) {
          provider.bnIndex = value;
        },
      ),
    );
  }
}
