import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class upload extends StatefulWidget {
  const upload({Key? key}) : super(key: key);

  @override
  State<upload> createState() => _uploadState();
}

class _uploadState extends State<upload> {
  final List<String> ilkYardimList = [];
  final List<String> hijyenList = [];
  final giyimList = [
    'Bandajlar',
    'Antiseptik solüsyon',
    'Termometre',
    'Ağrı kesici',
    'Steril gazlı bez',
    'Yara bandı',
    'Sargı bezi',
    'Eldiven',
    'Diş fırçası ve diş macunu',
    'Şampuan',
    'Hijyenik ped',
    'Tıraş bıçağı ve köpük',
    'Tarak',
    'Vücut losyonu',
    'Islak mendil',
    'Duş jeli',
    'Tuvalet kağıdı',
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
  final gidaList = [];
  Future<void> yazToFirestore() async {
    for (String item in giyimList) {
      await FirebaseFirestore.instance
          .collection('tedarikci')
          .doc('12345')
          .collection('stok')
          .doc(item)
          .set({
        'konum': 'Ereğli',
        'stok':
            300, // başlangıç stok miktarı, istediğiniz gibi ayarlayabilirsiniz
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('İlk Yardım Malzemeleri Ekle'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: yazToFirestore,
          child: Text('İlk Yardım Malzemelerini Firebase\'e Yaz'),
        ),
      ),
    );
  }
}
