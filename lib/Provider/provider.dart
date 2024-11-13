import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import 'cart_item.dart';
import 'database_helper.dart';

class myProv extends ChangeNotifier {
  int _BNindex = 0;
  final _uuid = Uuid();

  String _name = '';
  String _email = '';
  String _phoneNumber = '';
  DateTime _birthDate = DateTime(2000, 1, 1);
  String _gender = 'Male';
  String _profileImagePath = 'assets/profil.jpg';
  bool _isDarkMode = false;
  bool _showBanner = true;
  final List<CartItem> _cartItems = [];
  List<String> _wishlist = [];
  String? _paymentStatus;
  Color? _bannerColor;

  int get bnIndex => _BNindex;
  bool get isDarkMode => _isDarkMode;
  bool get showBanner => _showBanner;
  List<CartItem> get cartItems => _cartItems;
  List<String> get wishlist => _wishlist;
  String get name => _name;
  String get email => _email;
  String get phoneNumber => _phoneNumber;
  DateTime get birthDate => _birthDate;
  String get gender => _gender;
  String get profileImagePath => _profileImagePath;
  String? get paymentStatus => _paymentStatus;
  Color? get bannerColor => _bannerColor;

  set bnIndex(int val) {
    _BNindex = val;
    notifyListeners();
  }

  myProv() {
    _loadUserData();
    _loadThemePreference();
    _loadWishlist();
  }

  void updateName(String newName) async {
    _name = newName;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('name', _name);
  }

  void updateEmail(String newEmail) async {
    _email = newEmail;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', _email);
  }

  void updatePhoneNumber(String newPhoneNumber) async {
    _phoneNumber = newPhoneNumber;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('phoneNumber', _phoneNumber);
  }

  void updateBirthDate(DateTime newDate) async {
    _birthDate = newDate;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('birthDate', newDate.toIso8601String());
  }

  void updateGender(String newGender) async {
    _gender = newGender;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('gender', _gender);
  }

  void updateProfileImagePath(String imagePath) async {
    _profileImagePath = imagePath;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('profileImagePath', _profileImagePath);
  }

  void toggleDarkMode() async {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', _isDarkMode);
  }

  void _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _name = prefs.getString('name') ?? 'Default Name';
    _email = prefs.getString('email') ?? 'default@example.com';
    _phoneNumber = prefs.getString('phoneNumber') ?? '000000000';
    _birthDate = DateTime.parse(prefs.getString('birthDate') ?? '2000-01-01');
    _gender = prefs.getString('gender') ?? 'Male';
    _profileImagePath =
        prefs.getString('profileImagePath') ?? 'assets/profil.jpg';
    notifyListeners();
  }

  void _loadCartItems() async {
    final cartData = await DatabaseHelper.instance.getCartItems();

    _cartItems.clear();
    for (var item in cartData) {
      _cartItems.add(CartItem(
        id: item['id'],
        name: item['name'],
        price: item['price'],
        quantity: item['quantity'],
        size: item['size'],
        iceLevel: item['iceLevel'],
        syrup: item['syrup'],
        imagePath: item['imagePath'],
        description: item['description'],
      ));
    }
    notifyListeners();
  }

  void _loadThemePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    notifyListeners();
  }

  void _loadWishlist() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _wishlist = prefs.getStringList('wishlist') ?? [];
    notifyListeners();
  }

  Future<void> addToCart(CartItem item) async {
    await DatabaseHelper.instance.insert(item);
    _loadCartItems();
  }

  Future<void> removeFromCart(CartItem item) async {
    await DatabaseHelper.instance.delete(item.id);
    _loadCartItems();
  }

  Future<void> updateCartItemQuantity(CartItem item, int newQuantity) async {
    item.quantity = newQuantity;
    await DatabaseHelper.instance.updateQuantity(item);
    _loadCartItems();
  }

  Future<void> clearCart() async {
    await DatabaseHelper.instance.clearCart();
    _loadCartItems();
  }

  Future<void> addToWishlist(String id) async {
    if (!_wishlist.contains(id)) {
      _wishlist.add(id);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setStringList('wishlist', _wishlist);
      notifyListeners();
    }
  }

  Future<void> removeFromWishlist(String id) async {
    _wishlist.remove(id);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('wishlist', _wishlist);
    notifyListeners();
  }

  bool isInWishlist(String id) {
    return _wishlist.contains(id);
  }

  void updatePaymentStatus(String status, Color color) {
    _paymentStatus = status;
    _bannerColor = color;
    notifyListeners();
  }

  void clearPaymentStatus() {
    _paymentStatus = null;
    _bannerColor = null;
    notifyListeners();
  }

  Stream<List<String>> getWishlistStream() {
    return Stream<List<String>>.periodic(
      Duration(seconds: 1),
      (_) => _wishlist,
    ).asBroadcastStream();
  }

  void setShowBanner(bool value) {
    _showBanner = value;
    notifyListeners();
  }

  String generateId() {
    return _uuid.v4();
  }
}
