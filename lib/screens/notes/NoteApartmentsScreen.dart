import 'dart:async';

import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';
import 'package:rent_application/models/HomePhoneModel.dart';
import 'package:rent_application/repository/firestore_srevice.dart';
import 'package:rent_application/screens/notes/AddHomePhoneForm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// The details screen for either the A or B screen.
class NoteApartmentsScreen extends StatefulWidget {
  /// Constructs a [NoteDetailScreen].
  const NoteApartmentsScreen({
    required this.label,
    required this.detailsApartmentPath,
    Key? key,
  }) : super(key: key);

  /// The label to display in the center of the screen.
  final String label;

  /// The path to the detail page
  final String detailsApartmentPath;

  @override
  State<StatefulWidget> createState() => NoteApartmentsScreenState();
}

/// The state for DetailsScreen
class NoteApartmentsScreenState extends State<NoteApartmentsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Квартиры - Список квартир'),
      ),
      body: _emptyMessage(),
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

Widget _emptyMessage() {
  return Center(
    child: Container(
      child: Text(
        'Квартир нет',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 14.0),
      ),
    ),
  );
}
