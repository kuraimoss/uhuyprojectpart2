import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Content/detailPage.dart';
import '../Content/orderDetail.dart';
import '../Content/wishlist.dart';
import '../Provider/cart_item.dart';
import '../Provider/provider.dart';

class MyMenu extends StatefulWidget {
  const MyMenu({Key? key}) : super(key: key);

  @override
  State<MyMenu> createState() => _MyMenuState();
}

class _MyMenuState extends State<MyMenu> {
  late List<CartItem> _cartItems;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<myProv>(context);
    _cartItems = cartProvider.cartItems;
    int totalHarga = 0;
    _cartItems.forEach((item) {
      int itemTotalPrice = item.price * item.quantity;

      if (item.size == 'Large') {
        itemTotalPrice += 5000;
      }

      if (item.syrup == 'Aren' || item.syrup == 'Vanilla') {
        itemTotalPrice += 5000;
      }

      totalHarga += itemTotalPrice;
    });

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
                      'Menu',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    ),
                    Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 10),
                          Icon(
                            Icons.location_on,
                            size: 30,
                            color: Color(0xFF357543),
                          ),
                          SizedBox(width: 10),
                          Container(
                            width: 1,
                            height: 30,
                            color: Colors.grey[400],
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Medan',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '1.2 Km',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      'Terdekat',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF357543),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          RawMaterialButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => WishlistPage()),
                              );
                            },
                            elevation: 2.0,
                            fillColor: Color(0xFF107d72),
                            constraints:
                                BoxConstraints.tightFor(width: 33, height: 33),
                            shape: CircleBorder(),
                            child: Center(
                              child: Icon(
                                Icons.favorite,
                                size: 21.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
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
      body: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(width: 1.0, color: Colors.grey),
            bottom: BorderSide(width: 1.0, color: Colors.grey),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: ListView(
          children: [
            Divider(color: Colors.grey, thickness: 1),
            _buildMenuItem(
                '2',
                'assets/machiato.jpg',
                'Cappucino Latte',
                'Perpaduan arabica coffee dengan susu karamel',
                'Rp 20.000',
                cartProvider),
            Divider(color: Colors.grey, thickness: 1),
            _buildMenuItem(
                '1',
                'assets/home2.jpg',
                'Coffe Latte',
                'Perpaduan arabica coffee dengan susu UHT',
                'Rp 25.000',
                cartProvider),
            Divider(color: Colors.grey, thickness: 1),
            _buildMenuItem('3', 'assets/home3.jpg', 'Americano Coffee',
                'Coffe 100% Arabica', 'Rp 15.000', cartProvider),
            Divider(color: Colors.grey, thickness: 1),
          ],
        ),
      ),
      floatingActionButton: _cartItems.isNotEmpty
          ? Container(
              height: 50,
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Item ${_cartItems.length}',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Rp $totalHarga',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => OrderPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Detail Order',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 8.0),
                          Icon(Icons.local_drink),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildMenuItem(String id, String imagePath, String title,
      String description, String price, myProv cartProvider) {
    bool isFavorite = cartProvider.isInWishlist(id);

    CartItem item = CartItem(
      id: cartProvider.generateId(),
      name: title,
      price: int.parse(price.replaceAll(RegExp(r'\D'), '')),
      quantity: 1,
      size: 'Regular',
      iceLevel: 'Normal',
      syrup: 'None',
      imagePath: imagePath,
      description: description,
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                imagePath,
                width: 150,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        SizedBox(width: 10),
        Container(
          width: 1,
          height: 80,
          color: Colors.grey[400],
        ),
        SizedBox(width: 16),
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(item: item),
                        ),
                      );
                    },
                    child: Text(
                      'Buy',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              Text(
                description,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Text(
                      price,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[800],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 100,
                  ),
                  Expanded(
                    flex: 2,
                    child: IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : null,
                      ),
                      onPressed: () {
                        setState(() {
                          if (isFavorite) {
                            cartProvider.removeFromWishlist(id);
                          } else {
                            cartProvider.addToWishlist(id);
                          }
                        });
                      },
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
