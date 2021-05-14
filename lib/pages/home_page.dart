import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:green_app/model/calon_ketua.dart';
import 'package:green_app/pages/calon_ketua_form_page.dart';
import 'package:green_app/pages/splash.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List data = [];
  CollectionReference votingKetuaCR = FirebaseFirestore.instance.collection('VotingKetua');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Green App'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Splash()));
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Card(
                child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
              child: Row(
                children: [StreamBuilder<List<CalonKetua>>(stream: getWinner(),builder: (context, snapshot) {
                  var winner = snapshot.data[0].nama;
                  return Text('Winner is $winner');
                },)],
              ),
            )),
            StreamBuilder<List<CalonKetua>>(
              stream: listCalonKetuaStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var listCalonKetua = snapshot.data;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: listCalonKetua.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        child: Card(
                          child: Container(
                            child: ListTile(
                              leading: Icon(Icons.person),
                              title: Text(listCalonKetua[index].nama),
                              trailing: Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  Text('${listCalonKetua[index].vote}',
                                      style: TextStyle(fontSize: 23, fontWeight: FontWeight.w800)),
                                  IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: () {
                                        votingKetuaCR.doc(listCalonKetua[index].calonId).delete();
                                      })
                                ],
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          votingKetuaCR
                              .doc(listCalonKetua[index].calonId)
                              .update({"vote": listCalonKetua[index].vote + 1});
                        },
                      );
                    },
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
            ElevatedButton(
              child: Text('Tambah Calon Ketua'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => CalonKetuaFormPage()));
              },
            ),
            // ElevatedButton(
            //   child: Text('Read'),
            //   onPressed: () async {
            //     await read();
            //     setState(() {});
            //   },
            // ),
            // Text(data.toString()),
            // ElevatedButton(
            //   child: Text('Update'),
            //   onPressed: () {
            //     update();
            //   },
            // ),
            // ElevatedButton(
            //   child: Text('Delete'),
            //   onPressed: () {
            //     delete();
            //   },
            // ),
          ],
        ),
      ),
    );
  }

  create() {
    votingKetuaCR.doc().set({'nama': 'Joni', 'kelompok': 10, 'isJomblo': true});
  }

  read() async {
    var qs = await votingKetuaCR.get();
    qs.docs.forEach((dqs) {
      data.add(dqs.data());
    });

    print('cek data');
  }

  Stream<List<CalonKetua>> listCalonKetuaStream() {
    return votingKetuaCR.snapshots().map((qs) {
      return qs.docs.map((dqs) {
        CalonKetua calonketua = CalonKetua.fromMap(dqs.data());
        return calonketua;
      }).toList();
    });
  }

    Stream<List<CalonKetua>> getWinner() {
    return votingKetuaCR.orderBy('vote',descending: true).limit(1).snapshots().map((qs) {
      return qs.docs.map((dqs) {
        CalonKetua calonketua = CalonKetua.fromMap(dqs.data());
        return calonketua;
      }).toList();
    });
  }

  update() {
    votingKetuaCR.doc('qQ3yVUdpregieSPvizIj').update({'calonId': 'calon01'});
  }

  delete() {
    votingKetuaCR.doc('qQ3yVUdpregieSPvizIj').delete();
  }
}
