import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider/cart_item.dart';
import '../Provider/provider.dart';
import 'detailPage.dart';

class WishlistPage extends StatelessWidget {
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
                top: 30,
                left: 20,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 25,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      borderRadius: BorderRadius.circular(20.0),
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.transparent,
                        ),
                        child: Transform.scale(
                          scale: 1,
                          child: Icon(Icons.arrow_back),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 20,
                right: 20,
                bottom: 30,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Wishlist',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
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
      body: StreamBuilder<List<String>>(
        stream: Provider.of<myProv>(context).getWishlistStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'Wishlist is empty',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            );
          }

          final wishlistItems = snapshot.data!;

          return ListView.builder(
            itemCount: wishlistItems.length,
            itemBuilder: (context, index) {
              final itemId = wishlistItems[index];
              final item = _getMenuItemById(itemId);
              final isFavorite = wishlistItems.contains(itemId);

              return Card(
                margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.only(right: 10.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              item.imagePath,
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
                                  item.name,
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
                                        builder: (context) =>
                                            DetailPage(item: item),
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
                              item.description,
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
                                    '\Rp ${item.price}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green[800],
                                    ),
                                  ),
                                ),
                                SizedBox(width: 100),
                                Expanded(
                                  flex: 2,
                                  child: IconButton(
                                    icon: Icon(
                                      isFavorite
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: isFavorite ? Colors.red : null,
                                    ),
                                    onPressed: () {
                                      final cartProvider = Provider.of<myProv>(
                                          context,
                                          listen: false);
                                      if (isFavorite) {
                                        cartProvider.removeFromWishlist(itemId);
                                      } else {
                                        cartProvider.addToWishlist(itemId);
                                      }
                                    },
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  CartItem _getMenuItemById(String id) {
    final menuItems = [
      CartItem(
        id: '1',
        name: 'Coffe Latte',
        price: 25000,
        quantity: 1,
        size: 'Regular',
        iceLevel: 'Normal',
        syrup: 'None',
        imagePath: 'assets/home2.jpg',
        description: 'Perpaduan arabica coffee dengan susu UHT',
      ),
      CartItem(
        id: '2',
        name: 'Cappucino Latte',
        price: 20000,
        quantity: 1,
        size: 'Regular',
        iceLevel: 'Normal',
        syrup: 'None',
        imagePath: 'assets/machiato.jpg',
        description: 'Perpaduan arabica coffee dengan susu karamel',
      ),
      CartItem(
        id: '3',
        name: 'Americano Coffee',
        price: 15000,
        quantity: 1,
        size: 'Regular',
        iceLevel: 'Normal',
        syrup: 'None',
        imagePath: 'assets/home3.jpg',
        description: 'Coffe 100% Arabica',
      ),
    ];

    return menuItems.firstWhere((item) => item.id == id);
  }
}
