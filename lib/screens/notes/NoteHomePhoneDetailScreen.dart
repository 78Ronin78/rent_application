import 'dart:async';

import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';
import 'package:rent_application/models/HomePhoneModel.dart';
import 'package:rent_application/repository/firestore_srevice.dart';
import 'package:rent_application/screens/notes/AddHomePhoneForm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// The details screen for either the A or B screen.
class NoteHomePhoneDetailScreen extends StatefulWidget {
  /// Constructs a [NoteDetailScreen].
  const NoteHomePhoneDetailScreen({
    required this.label,
    required this.detailsHomePhonePath,
    Key? key,
  }) : super(key: key);

  /// The label to display in the center of the screen.
  final String label;

  /// The path to the detail page
  final String detailsHomePhonePath;

  @override
  State<StatefulWidget> createState() => NoteHomePhoneDetailScreenState();
}

//функция преобразования списка снапшотов коллекции в список сообщений
StreamTransformer documentToHomePhonesTransformer = StreamTransformer<
        QuerySnapshot<Map<String, dynamic>>, List<HomePhoneModel>>.fromHandlers(
    handleData: (QuerySnapshot<Map<String, dynamic>> snapShot,
        EventSink<List<HomePhoneModel>> sink) {
  List<HomePhoneModel> result = [];
  snapShot.docs.forEach((element) {
    FirestoreService.getHomePhones(element.id).then((value) {
      if (value != null) {
        final snaps = snapShot.docs.map((doc) => doc.data()).toList();
        final users =
            snaps.map((json) => HomePhoneModel.fromJson(json)).toList();
        result.add(HomePhoneModel.fromJson(value));
        sink.add(result = List.from(result.reversed));
      }
    });
  });
  print('Результат: ${result.length}');
  sink.add(result = List.from(result.reversed));
});

/// The state for DetailsScreen
class NoteHomePhoneDetailScreenState extends State<NoteHomePhoneDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Домофоны - Список домофонов'),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('homePhones')
              .snapshots()
              .transform(documentToHomePhonesTransformer),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return Container();
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            showDialog(
                context: context, builder: (context) => AddHomePhoneForm());
          });
        },
        //Beamer.of(context).beamToNamed(widget.detailsHomePhonePath),
        tooltip: 'Добавить',
        child: const Icon(Icons.add),
      ),
    );
  }
}
