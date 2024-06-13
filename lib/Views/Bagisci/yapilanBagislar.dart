import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farukhelp/Views/Tedarikci/tedarikciStok.dart';
import 'package:farukhelp/Views/logInPG.dart';
import 'package:flutter/material.dart';

class YapilanbagislarPG extends StatefulWidget {
  final bool isBagisci;
  const YapilanbagislarPG({super.key, required this.isBagisci});

  @override
  State<YapilanbagislarPG> createState() => _YapilanbagislarPGState();
}

class _YapilanbagislarPGState extends State<YapilanbagislarPG> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    CollectionReference tedarikciRef = _firestore.collection('bagisci');
    CollectionReference depremzedeRef = _firestore.collection('depremzede');
    var tedarikciStokRef =
        tedarikciRef.doc(currentUserTc).collection('yapilanBagis');
    var depremzedeStokRef =
        depremzedeRef.doc(currentUserTc).collection('ihtiyac');

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isBagisci ? 'Yapılan Bağışlar' : 'İhtiyaçlarım'),
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            TitleForList(
                title: widget.isBagisci ? 'Bağışlarım' : 'İhtiyaçlarım'),
            StreamBuilder(
              stream: widget.isBagisci
                  ? tedarikciStokRef.snapshots()
                  : depremzedeStokRef.snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    var doc = snapshot.data?.docs[index];

                    return TedarikciListElement(
                      tedarikciAdi: doc!['konum'].toString(),
                      urunAdi: doc!['urunAdi'].toString(),
                      urunMiktari: doc!['urunMiktari'].toString(),
                      isBagis: widget.isBagisci,
                      tedarikciID: doc!['tedarikciID'],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class TitleForList extends StatelessWidget {
  final String title;
  const TitleForList({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
          thickness: 4,
          color: Colors.black,
        ),
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Divider(
          thickness: 4,
          color: Colors.black,
        ),
      ],
    );
  }
}
