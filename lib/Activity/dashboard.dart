import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart'; // Import AdMob
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

  // Deklarasi Interstitial Ad
  late InterstitialAd _interstitialAd;
  bool _isInterstitialAdReady = false;

  @override
  void initState() {
    super.initState();

    // Inisialisasi PageController
    final provider = Provider.of<myProv>(context, listen: false);
    _pageController = PageController(initialPage: provider.bnIndex);

    // Memuat iklan interstitial
    _loadInterstitialAd();
  }

  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/1033173712', // Ganti dengan ID Unit Iklan Anda
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
          _isInterstitialAdReady = true;

          // Menampilkan iklan jika sudah siap
          _showInterstitialAd();
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('Failed to load interstitial ad: $error');
        },
      ),
    );
  }

  void _showInterstitialAd() {
    if (_isInterstitialAdReady) {
      _interstitialAd.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (InterstitialAd ad) {
          ad.dispose();
          print('Interstitial Ad dismissed.');
        },
        onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
          ad.dispose();
          print('Failed to show interstitial ad: $error');
        },
      );

      _interstitialAd.show();
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    if (_isInterstitialAdReady) {
      _interstitialAd.dispose();
    }
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
