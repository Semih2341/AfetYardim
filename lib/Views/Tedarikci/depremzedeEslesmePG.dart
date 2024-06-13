import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farukhelp/Views/Bagisci/yapilanBagislar.dart';
import 'package:farukhelp/Views/logInPG.dart';
import 'package:flutter/material.dart';

class DepremzedeeslesmePG extends StatefulWidget {
  const DepremzedeeslesmePG({super.key});

  @override
  State<DepremzedeeslesmePG> createState() => _DepremzedeeslesmePGState();
}

class _DepremzedeeslesmePGState extends State<DepremzedeeslesmePG> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    CollectionReference tedarikciRef = _firestore.collection('tedarikci');
    var tedarikciStokRef =
        tedarikciRef.doc(currentUserTc).collection('tedarikIstek');
    return Scaffold(
      appBar: AppBar(
        title: Text('Tedarik İstekleri'),
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            TitleForList(title: 'İstekler'),
            StreamBuilder(
              stream: tedarikciStokRef.snapshots(),
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

                    return mySpecialContainer(
                        konum: doc!['konum'].toString(),
                        urunAdi: doc!['urunAdi'].toString(),
                        urunMiktari: doc!['urunMiktari'].toString());
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

class mySpecialContainer extends StatelessWidget {
  final String konum;
  final String urunAdi;
  final String urunMiktari;
  const mySpecialContainer({
    Key? key,
    required this.konum,
    required this.urunAdi,
    required this.urunMiktari,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(border: Border(bottom: BorderSide())),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Flexible(
            child: Text(
              '$konum : ',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Flexible(
            child: Text(
              '$urunAdi :',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Flexible(
            child: Text(
              urunMiktari,
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
