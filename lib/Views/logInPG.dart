// ignore_for_file: file_names, camel_case_types, prefer_const_constructors

import 'package:farukhelp/anasayfa.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

var usertip;
var currentUserTc = '';

class logInPG extends StatefulWidget {
  const logInPG({super.key});

  @override
  State<logInPG> createState() => _logInPGState();
}

class _logInPGState extends State<logInPG> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 100.0),
                  child: Container(
                    child: Image.asset(
                      'assets/edk-logo.jpg',
                    ),
                    width: 200,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 100.0),
                  child: Container(
                    child: Image.asset('assets/sagust.jpg'),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 250),
                  child: Text(
                    "Giriş Yap",
                    style: TextStyle(
                      fontSize: 50,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      right: 20, left: 20, bottom: 20, top: 340),
                  child: TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                          onPressed: () {
                            usernameController.clear();
                          },
                          icon: Icon(Icons.clear),
                        ),
                        labelText: 'Tc Kimlik Numarası',
                        hintText: '12345 '),
                    onChanged: (value) => setState(
                      () {},
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 20, left: 20, bottom: 20, top: 0),
                  child: TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                          onPressed: () {
                            passwordController.clear();
                          },
                          icon: Icon(Icons.clear),
                        ),
                        labelText: 'Şifre',
                        hintText: '123456 '),
                    onChanged: (value) => setState(
                      () {},
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Center(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 0.0),
                            child: eDevletButon(
                              userContents: {
                                'TC': usernameController.text,
                                'sifre': passwordController.text
                              },
                              image: NetworkImage(
                                  'https://i0.wp.com/senyor.app/wp-content/uploads/2023/01/indir.png?resize=720%2C284&ssl=1'),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class eDevletButon extends StatelessWidget {
  final ImageProvider image;
  Map<String, String> userContents = {};

  eDevletButon({required this.image, required this.userContents});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        logIn(userContents, context);
      },
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: image,
            fit: BoxFit.cover,
          ),
        ),
        width: 300,
        height: 100.0,
      ),
    );
  }

  void _onPressed(context) {
    if (userType == 1) {
      Navigator.pushReplacementNamed(context, '/tedarikciMain');
    }
    if (userType == 2) {
      Navigator.pushReplacementNamed(context, '/bagisciMain');
    }
    if (userType == 3) {
      Navigator.pushReplacementNamed(context, '/depremzedeMain');
    }
  }

  void logIn(userContents, context) async {
    switch (userType) {
      case 1:
        usertip = 'tedarikci';
        break;
      case 2:
        usertip = 'bagisci';
        break;
      case 3:
        usertip = 'depremzede';
        break;
    }
    if (userContents['TC'] == null || userContents['sifre'] == null) {
      print('Kullanıcı Adı veya Şifre Boş');
    }
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    CollectionReference usersRef = firestore.collection(usertip);
    print(
        'Kullanıcı Adı: ${userContents['TC']} + Şifre: ${userContents['sifre']}');

    var username = usersRef.doc(userContents['TC'] as String);
    var response = await username.get();
    if (response.exists) {
      var map = response.data() as Map<String, dynamic>;
      /*var stokmap = map['stok'] as Map<String, dynamic>;
      print('Stok:' + stokmap.keys.toList()[1].toString());*/
      print('Kullanıcı Bulundu');
      if (map['sifre'] == userContents['sifre']) {
        print('Giriş Başarılı');
        currentUserTc = userContents['TC'] as String;
        _onPressed(context);
      } else {
        print('Şifre Yanlış');
      }
    } else {
      print('Kullanıcı Bulunamadı');
    }

    /*usersRef
        .doc('141212')
        .get()
        .usersRef
        .doc('141212')
        .set(
          {'sifre': 124422},
        ) // <-- Your data
        .then((_) => print('Added'))
        .catchError(
          (error) => print('Add failed: $error'),
        );
  }*/
  }
}
