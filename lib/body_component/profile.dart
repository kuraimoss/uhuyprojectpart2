import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../Activity/home.dart';
import '../Provider/database_helper.dart';
import '../Provider/provider.dart';

class MyProfile extends StatefulWidget {
  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  File? _image;

  Future<void> _logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      await DatabaseHelper.instance.logoutUser();

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Myhome()),
        (Route<dynamic> route) => false,
      );
    } catch (e) {
      print("Error during logout: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to log out. Please try again.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer<myProv>(
          builder: (context, profileProvider, _) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 30),
                Text(
                  'My Profile',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: _image != null
                      ? FileImage(_image!)
                      : AssetImage('assets/profil.jpg')
                          as ImageProvider<Object>?,
                ),
                SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditProfile()),
                    );
                  },
                  icon: Icon(Icons.edit_outlined, size: 18),
                  label: Text('Edit Profile'),
                ),
                buildField('Name', profileProvider.name),
                buildField('Email', profileProvider.email),
                buildField('Phone Number', profileProvider.phoneNumber),
                buildDateField('Birth Date', profileProvider.birthDate),
                buildField('Jenis Kelamin', profileProvider.gender),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(flex: 1, child: SizedBox()),
                    Expanded(flex: 4, child: Text('Dark Mode')),
                    Expanded(
                      flex: 4,
                      child: Switch(
                        value: profileProvider.isDarkMode,
                        onChanged: (value) {
                          profileProvider.toggleDarkMode();
                        },
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: _logout,
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.red),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                      ),
                      child: Text('Logout'),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget buildField(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              readOnly: true,
              controller: TextEditingController(text: value),
              decoration: InputDecoration(
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                labelText: label,
                labelStyle: TextStyle(color: Colors.grey),
                contentPadding: EdgeInsets.fromLTRB(0, 8, 0, 8),
              ),
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildDateField(String label, DateTime value) {
    final formattedDate = '${value.day}/${value.month}/${value.year}';
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              readOnly: true,
              controller: TextEditingController(text: formattedDate),
              decoration: InputDecoration(
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                labelText: label,
                labelStyle: TextStyle(color: Colors.grey),
                contentPadding: EdgeInsets.fromLTRB(0, 8, 0, 8),
              ),
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }
}

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  String _selectedGender = '';
  DateTime _selectedDate = DateTime.now();
  File? _image;
  int _selectedDay = 1;
  int _selectedYear = DateTime.now().year;
  String _selectedMonth = 'Januari';

  final List<String> _months = [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember'
  ];

  @override
  void initState() {
    super.initState();
    final profileProvider = Provider.of<myProv>(context, listen: false);
    _nameController.text = profileProvider.name;
    _emailController.text = profileProvider.email;
    _phoneNumberController.text = profileProvider.phoneNumber;
    _selectedGender = profileProvider.gender;
    _selectedDate = profileProvider.birthDate;
    _selectedDay = _selectedDate.day;
    _selectedMonth = _months[_selectedDate.month - 1];
    _selectedYear = _selectedDate.year;
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<myProv>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: _image != null
                      ? FileImage(_image!)
                      : AssetImage('assets/profil.jpg')
                          as ImageProvider<Object>?,
                ),
                SizedBox(width: 20),
                Expanded(
                  child: InkWell(
                    onTap: _getImage,
                    child: Row(
                      children: [
                        Icon(Icons.camera_alt),
                        SizedBox(width: 10),
                        Text(
                          'Change Profile Picture',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              controller: _phoneNumberController,
              decoration: InputDecoration(labelText: 'Phone Number'),
            ),
            DropdownButtonFormField<String>(
              value: _selectedGender,
              onChanged: (value) {
                setState(() {
                  _selectedGender = value!;
                });
              },
              items: ['Male', 'Female']
                  .map((gender) => DropdownMenuItem(
                        value: gender,
                        child: Text(gender),
                      ))
                  .toList(),
              decoration: InputDecoration(labelText: 'Gender'),
            ),
            SizedBox(height: 20),
            Text('Birth Date'),
            Row(
              children: [
                Expanded(
                  child: DropdownButton<int>(
                    value: _selectedDay,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedDay = newValue!;
                      });
                    },
                    items: List.generate(31, (index) => index + 1)
                        .map((day) => DropdownMenuItem(
                              value: day,
                              child: Text(day.toString()),
                            ))
                        .toList(),
                  ),
                ),
                Expanded(
                  child: DropdownButton<String>(
                    value: _selectedMonth,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedMonth = newValue!;
                      });
                    },
                    items: _months
                        .map((month) => DropdownMenuItem(
                              value: month,
                              child: Text(month),
                            ))
                        .toList(),
                  ),
                ),
                Expanded(
                  child: DropdownButton<int>(
                    value: _selectedYear,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedYear = newValue!;
                      });
                    },
                    items: List.generate(
                            100, (index) => DateTime.now().year - index)
                        .map((year) => DropdownMenuItem(
                              value: year,
                              child: Text(year.toString()),
                            ))
                        .toList(),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final monthIndex = _months.indexOf(_selectedMonth) + 1;
                final newDate =
                    DateTime(_selectedYear, monthIndex, _selectedDay);
                profileProvider.updateName(_nameController.text);
                profileProvider.updateEmail(_emailController.text);
                profileProvider.updatePhoneNumber(_phoneNumberController.text);
                profileProvider.updateGender(_selectedGender);
                profileProvider.updateBirthDate(newDate);

                if (_image != null) {
                  profileProvider.updateProfileImagePath(_image!.path);
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content:
                          Text('Your profile has been successfully edited'),
                      duration: Duration(seconds: 2),
                      backgroundColor: Color(0xFF107d72)),
                );
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);

        final profileProvider = Provider.of<myProv>(context, listen: false);
        profileProvider.updateProfileImagePath(pickedFile.path);
      } else {
        final profileProvider = Provider.of<myProv>(context, listen: false);
        String defaultImagePath = profileProvider.profileImagePath;

        if (defaultImagePath == 'assets/profil.jpg' ||
            defaultImagePath.isEmpty) {
          _image = null;
        } else {
          _image = File(defaultImagePath);
        }
      }
    });
  }
}
