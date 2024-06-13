import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farukhelp/Views/Bagisci/esyaListesiPG.dart';
import 'package:farukhelp/Views/Tedarikci/tedarikciMainPG.dart';
import 'package:farukhelp/Views/logInPG.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:farukhelp/Views/locationService.dart';

class TedarikciSecim extends StatefulWidget {
  final bool isBagisci;
  const TedarikciSecim({super.key, required this.isBagisci});
  @override
  State<TedarikciSecim> createState() => _TedarikciSecimState();
}

class _TedarikciSecimState extends State<TedarikciSecim> {
  int distanceKozlu = 0;
  int distanceEregli = 0;
  int distanceMerkez = 0;
  @override
  void initState() {
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tedarikçi Seçim'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Text(
              'Tedarikci Seçiniz',
              style: TextStyle(fontSize: 20),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyMenuElevetedButton(
                    function: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BagislistesiPG(
                              isBagisci: widget.isBagisci,
                              tedarikciAdi: 'Kozlu'),
                        ),
                      );
                    },
                    buttonText: 'Kozlu (${distanceKozlu} KM)'),
                MyMenuElevetedButton(
                    function: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BagislistesiPG(
                              isBagisci: widget.isBagisci,
                              tedarikciAdi: 'Merkez'),
                        ),
                      );
                    },
                    buttonText: 'Merkez (${distanceMerkez} KM)'),
                MyMenuElevetedButton(
                    function: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BagislistesiPG(
                              isBagisci: widget.isBagisci,
                              tedarikciAdi: 'Ereğli'),
                        ),
                      );
                    },
                    buttonText: 'Ereğli (${distanceEregli} KM)'),
              ],
            )
          ],
        ),
      ),
    );
  }

  void getLocation() async {
    final service = LocationService();
    final locationData = await service.getLocation();
    double distanceMetreKozlu = await Geolocator.distanceBetween(
        locationData?.latitude ?? 0,
        locationData?.longitude ?? 0,
        41.439138538347315,
        31.754023855210175);
    double distanceMetreEregli = await Geolocator.distanceBetween(
        locationData?.latitude ?? 0,
        locationData?.longitude ?? 0,
        41.28274178764086,
        31.42945269809222);
    double distanceMetreMerkez = await Geolocator.distanceBetween(
        locationData?.latitude ?? 0,
        locationData?.longitude ?? 0,
        41.4453564684481,
        31.778870753467544);
    setState(() {
      distanceMerkez = (distanceMetreMerkez / 1000).toInt();
      distanceEregli = (distanceMetreEregli / 1000).toInt();
      distanceKozlu = (distanceMetreKozlu / 1000).toInt();
      print(distanceMerkez);
    });
  }
}

class GidaSecim extends StatefulWidget {
  final String tedarikciName;
  final String kategori;
  final bool isBagisci;
  const GidaSecim(
      {super.key,
      required this.isBagisci,
      required this.tedarikciName,
      required this.kategori});

  @override
  State<GidaSecim> createState() => _GidaSecimState();
}

class _GidaSecimState extends State<GidaSecim> {
  var itemList = [];
  final giyimList = [
    'Isı yalıtımlı battaniye',
    'Kazak',
    'Mont',
    'Bere',
    'Eldiven',
    'Yağmurluk',
    'Çorap',
    'Ayakkabı',
    'Şapka',
    'Atkı',
    'Termal içlik',
    'Polar mont',
    'Eldiven',
  ];
  final ilkYardimList = [
    'İlk yardım kiti',
    'Bandajlar',
    'Antiseptik solüsyon',
    'Termometre',
    'Ağrı kesici',
    'Steril gazlı bez',
    'Yara bandı',
    'Sargı bezi',
    'Eldiven',
  ];
  final hijyenList = [
    'Diş fırçası ve diş macunu',
    'Şampuan',
    'Hijyenik ped',
    'Tıraş bıçağı ve köpük',
    'Tarak',
    'Vücut losyonu',
    'Islak mendil',
    'Duş jeli',
    'Tuvalet kağıdı',
  ];

  final gidaList = [
    'Su(şişelenmiş su)',
    'Konserve yiyecek kutusu',
    'Kuru gıda kutusu',
    'Konserve meyve ve sebzeler',
    'Tahıl kutusu',
    'Un',
    'Şeker',
    'Tuz',
    'Zeytinyağı',
    'Ayçiçek yağı',
    'Süt',
    'Bebek mamaları',
    'Enerji barları',
    'Kuruyemiş kutusu',
    'Bal',
    'Bisküvi',
    'Kahve',
    'Çay',
    'Meyve suyu',
    'Çikolata veya şekerleme',
    'Bebek maması',
    'Hazır çorba',
    'Pirinç',
    'Makarna',
    'Salça',
    'Kurutulmuş meyve',
    'Salamura zeytin',
    'Reçel',
    'Cips ve atıştırmalıklar',
    'Kraker',
  ];
  @override
  void initState() {
    // TODO: implement initState
    print(widget.kategori);
    switch (widget.kategori) {
      case 'Giyim ':
        itemList = giyimList;
        print(itemList[0]);

        break;
      case 'İlk Yardım':
        itemList = ilkYardimList;
        print(itemList[0]);

        break;
      case 'Hijen ':
        itemList = hijyenList;
        print(itemList[0]);
        break;
      case 'Gıda ':
        itemList = gidaList;
        print(itemList[0]);

        break;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isBagisci
            ? '${widget.tedarikciName} İçin ${widget.kategori} Bağışı'
            : '${widget.kategori} Listesi'),
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('${widget.tedarikciName} İçin Gıda Seçiniz'),
            SizedBox(
              height: MediaQuery.of(context).size.height * .8,
              child: ListView.builder(
                  itemCount: itemList.length,
                  itemBuilder: (context, index) {
                    return MyElevetedButton(
                        function: () {
                          countDialog(itemList[index]);
                        },
                        buttonText: itemList[index]);
                  }),
            ),
          ],
        ),
      ),
    );
  }

  void countDialog(String item) {
    TextEditingController count = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(widget.isBagisci
              ? 'Kaç Adet ${item} Bağışlamak İstiyorsunuz?'
              : 'Kaç Adet ${item} İhtiyacınız Var?'),
          content: TextField(
            controller: count,
          ),
          actions: <Widget>[
            TextButton(
              child: Text('İptal Et'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Onayla'),
              onPressed: () {
                updateStok(item, int.parse(count.text));
                // İşlemleri buraya ekleyin
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void updateStok(String item, int count) async {
    int? tedarikciId;
    switch (widget.tedarikciName) {
      case 'Kozlu':
        tedarikciId = 12344;
        break;
      case 'Merkez':
        tedarikciId = 12345;
        break;
      case 'Ereğli':
        tedarikciId = 12343;
        break;
    }
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference tedarikciRef = firestore.collection('tedarikci');
    CollectionReference bagisciRef = firestore.collection('bagisci');
    CollectionReference depremzedeRef = firestore.collection('depremzede');
    var bagisciUser = bagisciRef.doc(currentUserTc).collection('yapilanBagis');
    var depremzedeUser = depremzedeRef.doc(currentUserTc).collection('ihtiyac');
    var tedarikciUser =
        tedarikciRef.doc(tedarikciId.toString()).collection('tedarikIstek');
    var itemRef =
        tedarikciRef.doc(tedarikciId.toString()).collection('stok').doc(item);
    var response = await itemRef.get();
    var map = response.data() as Map<String, dynamic>;

    print('bağicimi' + widget.isBagisci.toString());
    if (widget.isBagisci) {
      bagisciUser.add({
        'konum': widget.tedarikciName,
        'urunAdi': item,
        'urunMiktari': count,
        'tedarikciID': tedarikciId.toString(),
      });
      itemRef.update({'stok': map['stok'] + count});
    } else {
      var depremzede = await depremzedeRef.doc(currentUserTc).get();
      var depremzedeMap = depremzede.data() as Map<String, dynamic>;
      depremzedeUser.add({
        'konum': widget.tedarikciName,
        'urunAdi': item,
        'urunMiktari': count,
        'tedarikciID': tedarikciId.toString()
      });
      itemRef.update({'stok': map['stok'] - count});
      tedarikciUser.add({
        'konum': depremzedeMap['name'],
        'urunAdi': item,
        'urunMiktari': count,
        'tedarikciID': tedarikciId.toString(),
      });
    }

    print(map['stok']);
  }
}
