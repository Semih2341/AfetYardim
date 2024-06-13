import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farukhelp/Views/Tedarikci/tedarikciStok.dart';
import 'package:farukhelp/Views/logInPG.dart';
import 'package:flutter/material.dart';

class StreamDeneme extends StatefulWidget {
  const StreamDeneme({super.key});

  @override
  State<StreamDeneme> createState() => _StreamDenemeState();
}

class _StreamDenemeState extends State<StreamDeneme> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    CollectionReference tedarikciRef = _firestore.collection('tedarikci');
    var tedarikciStokRef = tedarikciRef.doc(currentUserTc).collection('stok');

    return Scaffold(
      appBar: AppBar(
        title: Text('Deneme'),
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
                tedarikciID: doc!['tedarikciID'],
              );
            },
          );
        },
      )),
    );
  }
}
