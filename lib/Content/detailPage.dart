import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider/cart_item.dart';
import '../Provider/provider.dart';

class DetailPage extends StatefulWidget {
  final CartItem item;

  const DetailPage({Key? key, required this.item}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int _itemCount = 1;
  bool _isLargeCupSelected = false;
  bool _isRegularCupSelected = true;
  bool _isLessIceSelected = false;
  bool _isNoIceSelected = false;
  bool _isNormalIceSelected = true;
  bool _isArenSyrupSelected = false;
  bool _isVanillaSyrupSelected = false;

  int _calculateTotalPrice(CartItem item) {
    int totalPrice = item.price * _itemCount;

    if (_isLargeCupSelected) {
      totalPrice += 5000;
    }

    if (_isArenSyrupSelected || _isVanillaSyrupSelected) {
      totalPrice += 5000;
    }

    return totalPrice;
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<myProv>(context);

    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30.0),
                      bottomRight: Radius.circular(30.0),
                    ),
                    child: Image.network(
                      widget.item.imagePath,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 30,
            left: 20,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 35,
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
                      scale: 1.3,
                      child: Icon(Icons.arrow_back),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.3,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.item.name,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 40,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      widget.item.description,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                Text(
                  'Rp ${widget.item.price}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.42,
            left: 0,
            right: 0,
            child: Divider(
              color: Color(0xFFd9d9d9),
              thickness: 6,
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.45,
            left: 20,
            child: Row(
              children: [
                Text(
                  'Size Cup',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.48,
            left: 20,
            child: Row(
              children: [
                Radio(
                  value: true,
                  groupValue: _isRegularCupSelected,
                  onChanged: (value) {
                    setState(() {
                      _isRegularCupSelected = value as bool;
                      _isLargeCupSelected = !value;
                    });
                  },
                ),
                Text(
                  'Regular cup',
                ),
              ],
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.52,
            left: 20,
            child: Row(
              children: [
                Radio(
                  value: true,
                  groupValue: _isLargeCupSelected,
                  onChanged: (value) {
                    setState(() {
                      _isLargeCupSelected = value as bool;
                      _isRegularCupSelected = !value;
                    });
                  },
                ),
                Text(
                  'Large cup',
                  style: TextStyle(color: Color(0xFF107d72)),
                )
              ],
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.57,
            left: 20,
            right: 20,
            child: Divider(
              color: Color(0xFFd9d9d9),
              thickness: 2,
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.595,
            left: 20,
            child: Row(
              children: [
                Text(
                  'Ice Level',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.62,
            left: 20,
            child: Row(
              children: [
                Radio(
                  value: true,
                  groupValue: _isLessIceSelected,
                  onChanged: (value) {
                    setState(() {
                      _isLessIceSelected = value as bool;
                      if (_isLessIceSelected) {
                        _isNoIceSelected = false;
                        _isNormalIceSelected = false;
                      }
                    });
                  },
                ),
                Text('Less Ice'),
              ],
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.66,
            left: 20,
            child: Row(
              children: [
                Radio(
                  value: true,
                  groupValue: _isNoIceSelected,
                  onChanged: (value) {
                    setState(() {
                      _isNoIceSelected = value as bool;
                      if (_isNoIceSelected) {
                        _isLessIceSelected = false;
                        _isNormalIceSelected = false;
                      }
                    });
                  },
                ),
                Text('No Ice'),
              ],
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.7,
            left: 20,
            child: Row(
              children: [
                Radio(
                  value: true,
                  groupValue: _isNormalIceSelected,
                  onChanged: (value) {
                    setState(() {
                      _isNormalIceSelected = value as bool;
                      if (_isNormalIceSelected) {
                        _isLessIceSelected = false;
                        _isNoIceSelected = false;
                      }
                    });
                  },
                ),
                Text('Normal Ice'),
              ],
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.75,
            left: 20,
            right: 20,
            child: Divider(
              color: Color(0xFFd9d9d9),
              thickness: 2,
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.785,
            left: 20,
            child: Row(
              children: [
                Text(
                  'Syrup',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.81,
            left: 20,
            child: Row(
              children: [
                Radio(
                  value: true,
                  groupValue: _isArenSyrupSelected,
                  onChanged: (value) {
                    setState(() {
                      _isArenSyrupSelected = value as bool;
                      if (_isArenSyrupSelected) {
                        _isVanillaSyrupSelected = false;
                      }
                    });
                  },
                ),
                Text('Aren'),
              ],
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.855,
            left: 20,
            child: Row(
              children: [
                Radio(
                  value: true,
                  groupValue: _isVanillaSyrupSelected,
                  onChanged: (value) {
                    setState(() {
                      _isVanillaSyrupSelected = value as bool;
                      if (_isVanillaSyrupSelected) {
                        _isArenSyrupSelected = false;
                      }
                    });
                  },
                ),
                Text('Vanilla'),
              ],
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.54,
            right: 20,
            child: Row(
              children: [
                Text(
                  '+Rp 5.000',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.816,
            right: 20,
            child: Row(
              children: [
                Text(
                  '+Rp 5.000',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.855,
            right: 20,
            child: Row(
              children: [
                Text(
                  '+Rp 5.000',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: Row(
              children: [
                Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[300],
                  ),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        if (_itemCount > 1) {
                          _itemCount--;
                        }
                      });
                    },
                    icon: Icon(Icons.remove, size: 20),
                  ),
                ),
                SizedBox(
                  width: 30,
                  child: Center(
                    child: Text(
                      '$_itemCount',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF107d72),
                  ),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        _itemCount++;
                      });
                    },
                    icon: Icon(Icons.add, size: 20),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            right: 14,
            child: ElevatedButton(
              onPressed: () {
                String size = _isLargeCupSelected ? 'Large' : 'Regular';
                String iceLevel = _isLessIceSelected
                    ? 'Less Ice'
                    : _isNoIceSelected
                        ? 'No Ice'
                        : 'Normal Ice';
                String syrup = _isArenSyrupSelected
                    ? 'Aren'
                    : _isVanillaSyrupSelected
                        ? 'Vanilla'
                        : 'None';

                CartItem newItem = CartItem(
                  id: cartProvider.generateId(),
                  name: widget.item.name,
                  price: widget.item.price,
                  quantity: _itemCount,
                  size: size,
                  iceLevel: iceLevel,
                  syrup: syrup,
                  imagePath: widget.item.imagePath,
                  description: widget.item.description,
                );

                cartProvider.addToCart(newItem);

                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                backgroundColor: Color(0xFF107d72),
              ),
              child: Text('Add - Rp ${_calculateTotalPrice(widget.item)}'),
            ),
          ),
        ],
      ),
    );
  }
}
