import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:green_app/model/calon_ketua.dart';
import 'package:green_app/pages/splash.dart';

class CalonKetuaFormPage extends StatefulWidget {
  @override
  _CalonKetuaFormPageState createState() => _CalonKetuaFormPageState();
}

class _CalonKetuaFormPageState extends State<CalonKetuaFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _nama;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add Calon Ketua'),
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
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Nama Calon', border: OutlineInputBorder()),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'nama tidak boleh kosong';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        _nama = newValue;
                      },
                    ),
                  ),
                  ElevatedButton(
                    child: Text('Simpan'),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        CollectionReference votingKetuaCR = FirebaseFirestore.instance.collection('VotingKetua');

                        var id = votingKetuaCR.doc().id;
                        CalonKetua calonketua = CalonKetua(calonId: id, nama: _nama, vote: 0, isActive: true);
                        votingKetuaCR.doc(id).set(calonketua.toMap());

                        Navigator.pop(context);
                      }
                    },
                  ),
                ],
              )),
        ));
  }
}
