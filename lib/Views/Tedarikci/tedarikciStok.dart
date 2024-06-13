import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farukhelp/Views/Tedarikci/massages.dart';
import 'package:farukhelp/Views/logInPG.dart';
import 'package:farukhelp/anasayfa.dart';
import 'package:flutter/material.dart';

class TedarikcistokPG extends StatefulWidget {
  const TedarikcistokPG({super.key});

  @override
  State<TedarikcistokPG> createState() => _TedarikcistokPGState();
}

class _TedarikcistokPGState extends State<TedarikcistokPG> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    CollectionReference tedarikciRef = _firestore.collection('tedarikci');
    var tedarikciStokRef = tedarikciRef.doc(currentUserTc).collection('stok');
    return Scaffold(
      appBar: AppBar(
        title: Text('Tedarikçi Stok'),
      ),
      body: Center(
          child: StreamBuilder(
        stream: tedarikciStokRef.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context, index) {
              var doc = snapshot.data?.docs[index];

              return TedarikciListElement(
                tedarikciAdi: doc!['konum'].toString(),
                urunAdi: doc!.id,
                urunMiktari: doc!['stok'].toString(),
                isBagis: false,
                tedarikciID: null.toString(),
              );
            },
          );
        },
      )),
    );
  }
}

Future<void> getTedarikciStok() async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference usersRef = firestore.collection(usertip);

  var username = usersRef.doc(currentUserTc as String);
  var response = await username.get();
  if (response.exists) {
    var map = response.data() as Map<String, dynamic>;
    var stokmap = map['stok'] as Map<String, dynamic>;
    print('Stok:' + stokmap.keys.toList()[1].toString());
  }
}

class TedarikciListElement extends StatelessWidget {
  final String tedarikciAdi;
  final String urunAdi;
  final String urunMiktari;
  final bool isBagis;
  final String tedarikciID;
  const TedarikciListElement({
    super.key,
    required this.tedarikciAdi,
    required this.urunAdi,
    required this.urunMiktari,
    required this.isBagis,
    required this.tedarikciID,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 100,
      decoration: BoxDecoration(border: Border(bottom: BorderSide())),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(tedarikciAdi + ' :'),
          Text(urunAdi + ' :'),
          Text(urunMiktari),
          if (isBagis && userType == 2)
            //BAĞIŞÇI İSE
            Container(
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Massages(
                          parentID: tedarikciID,
                          ownerName: tedarikciAdi + ' Şube',
                          ownerID: currentUserTc,
                          isTedarikci: false),
                    ),
                  );
                },
                icon: Icon(Icons.message),
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          if (!isBagis && userType == 3)
            //DEPREMZEDE İSE
            Container(
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Massages(
                          parentID: tedarikciID,
                          ownerName: tedarikciAdi + ' Şube',
                          ownerID: currentUserTc,
                          isTedarikci: false),
                    ),
                  );
                },
                icon: Icon(Icons.message),
              ),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
        ],
      ),
    );
  }
}
