import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farukhelp/Views/Bagisci/yapilanBagislar.dart';
import 'package:farukhelp/Views/logInPG.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MassageSelectionPG extends StatefulWidget {
  final String owner;
  const MassageSelectionPG({super.key, required this.owner});

  @override
  State<MassageSelectionPG> createState() => _MassageSelectionPGState();
}

class _MassageSelectionPGState extends State<MassageSelectionPG> {
  late String owner;
  late bool isTedarik;

  @override
  void initState() {
    super.initState();
    switch (widget.owner) {
      case 'tedarikci':
        isTedarik = true;
        break;
      case 'depremzede':
        isTedarik = false;
        break;
      case 'bagisci':
        isTedarik = false;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mesaj Seçiniz'),
      ),
      body: isTedarik
          ? Column(
              children: [
                const TitleForList(title: 'Depremzedeler'),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('depremzede')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(
                            child: Text('Bir hata oluştu: ${snapshot.error}'));
                      } else if (!snapshot.hasData ||
                          snapshot.data!.docs.isEmpty) {
                        return Center(child: Text('Henüz tedarikçi yok.'));
                      } else {
                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            var doc = snapshot.data!.docs[index];
                            return ListTile(
                              title: Text(doc['name']),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Massages(
                                      parentID: doc.id,
                                      ownerID: doc.id,
                                      ownerName: doc['name'],
                                      isTedarikci: true,
                                    ),
                                  ),
                                );
                                print(doc.id);
                              },
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
                const TitleForList(title: 'Bağışçılar'),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('bagisci')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(
                            child: Text('Bir hata oluştu: ${snapshot.error}'));
                      } else if (!snapshot.hasData ||
                          snapshot.data!.docs.isEmpty) {
                        return Center(child: Text('Henüz tedarikçi yok.'));
                      } else {
                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            var doc = snapshot.data!.docs[index];
                            return ListTile(
                              title: Text(doc['name']),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Massages(
                                      parentID:
                                          isTedarik ? currentUserTc : doc.id,
                                      ownerID: doc.id,
                                      ownerName: doc['name'],
                                      isTedarikci: true,
                                    ),
                                  ),
                                );
                                print(doc.id);
                              },
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ],
            )
          : Column(
              children: [
                const TitleForList(title: 'Tedarikçiler'),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('tedarikci')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(
                            child: Text('Bir hata oluştu: ${snapshot.error}'));
                      } else if (!snapshot.hasData ||
                          snapshot.data!.docs.isEmpty) {
                        return Center(child: Text('Henüz tedarikçi yok.'));
                      } else {
                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            var doc = snapshot.data!.docs[index];
                            return Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(color: Colors.grey),
                                ),
                              ),
                              child: ListTile(
                                title: Text(doc['name']),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Massages(
                                        parentID: doc.id,
                                        ownerID: currentUserTc,
                                        ownerName: doc['name'],
                                        isTedarikci: false,
                                      ),
                                    ),
                                  );
                                  print(doc.id);
                                },
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
    );
  }
}

class Massages extends StatefulWidget {
  final bool isTedarikci;
  final String ownerID;
  final String ownerName;
  final String parentID;
  const Massages(
      {super.key,
      required this.ownerID,
      required this.isTedarikci,
      required this.ownerName,
      required this.parentID});

  @override
  State<Massages> createState() => _MassagesState();
}

class _MassagesState extends State<Massages> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var isEmpty;
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.ownerName} ile Mesajlar"),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('tedarikci')
                  .doc(widget.isTedarikci ? currentUserTc : widget.parentID)
                  .collection('massages')
                  .doc('massagesFrom${widget.ownerID}')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                      child: Text('Bir hata oluştu: ${snapshot.error}'));
                } else if (!snapshot.hasData || !snapshot.data!.exists) {
                  isEmpty = true;
                  return Center(child: Text('Henüz mesaj yok.'));
                } else {
                  isEmpty = false;
                  var data = snapshot.data!.data() as Map<String, dynamic>;
                  var messages = data['messages'] as List<dynamic>;

                  return ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      var message = messages[index] as Map<String, dynamic>;
                      if (widget.isTedarikci) {
                        return message['isSent']
                            ? SentMessage(
                                message: message['content'],
                                timestamp:
                                    formatTimestamp(message['timestamp']),
                              )
                            : ReceivedMessage(
                                message: message['content'],
                                timestamp:
                                    formatTimestamp(message['timestamp']),
                              );
                      } else {
                        return message['isSent']
                            ? ReceivedMessage(
                                message: message['content'],
                                timestamp: message['timestamp'],
                              )
                            : SentMessage(
                                message: message['content'],
                                timestamp:
                                    formatTimestamp(message['timestamp']),
                              );
                      }
                    },
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    sendMessage(
                      widget.isTedarikci ? currentUserTc : widget.parentID,
                      _controller.text,
                      widget.ownerID,
                      isEmpty,
                    );
                    _controller.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String formatTimestamp(String timestamp) {
    DateTime dateTime = DateTime.parse(timestamp);
    String formattedTime = DateFormat('HH:mm\nyyyy-MM-dd').format(dateTime);
    return formattedTime;
  }

  void sendMessage(String tedarikciId, String content, String messageId,
      bool isEmpty) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    if (isEmpty) {
      await firestore
          .collection('tedarikci')
          .doc(tedarikciId)
          .collection('massages')
          .doc('massagesFrom${messageId}')
          .set(
        {
          'messages': [
            {
              'content': content,
              'timestamp': DateTime.now().toIso8601String(),
              'isSent': widget.isTedarikci,
              'id': messageId,
            }
          ],
        },
      );
    } else {
      await firestore
          .collection('tedarikci')
          .doc(tedarikciId)
          .collection('massages')
          .doc('massagesFrom${messageId}')
          .update(
        {
          'messages': FieldValue.arrayUnion([
            {
              'content': content,
              'timestamp': DateTime.now().toIso8601String(),
              'isSent': widget.isTedarikci,
              'id': messageId,
            }
          ])
        },
      );
    }
  }
}

class SentMessage extends StatelessWidget {
  final String message;
  final String timestamp;

  const SentMessage({required this.message, required this.timestamp});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 100.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 5.0),
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                message,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 5.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    timestamp.substring(0, 5), // Sadece saat ve dakikayı al
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12.0,
                    ),
                  ),
                  Text(
                    timestamp.substring(6), // Yıl, ay ve günü al
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReceivedMessage extends StatelessWidget {
  final String message;
  final String timestamp;

  const ReceivedMessage({required this.message, required this.timestamp});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 100.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 5.0),
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                message,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 5.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    timestamp.substring(0, 5), // Sadece saat ve dakikayı al
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12.0,
                    ),
                  ),
                  Text(
                    timestamp.substring(6), // Yıl, ay ve günü al
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
