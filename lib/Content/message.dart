import 'package:flutter/material.dart';

class NotifikasiPage extends StatelessWidget {
  const NotifikasiPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 40.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              Text(
                'Notification',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              SizedBox(width: 48.0),
            ],
          ),
          SizedBox(height: 8.0),
          Expanded(
            child: ListView.separated(
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                String sender = index.isEven ? 'John' : 'Jane';
                bool isMe = index.isEven;

                return ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(
                              text: 'DAILY CHECK IN\n',
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: 'Daily Check In\n',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text:
                                  'Yuk coba fitur Daily Check In sekarang juga di aplikasi KURA SHOP',
                              style: TextStyle(
                                fontSize: 14.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  trailing: Text(
                    '05 Mei 2024, 10.00',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12.0,
                    ),
                  ),
                  onTap: () {
                    print('Pesan dari $sender ditekan');

                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Delete Message'),
                          content: Text(
                              'Are you sure you want to delete this message?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(false);
                              },
                              child: Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(true);
                              },
                              child: Text('Delete'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  selected: isMe,
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  Divider(height: 1),
            ),
          ),
        ],
      ),
    );
  }
}
