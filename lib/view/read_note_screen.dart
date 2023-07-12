import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note_firebase/view/edit_screen.dart';
import 'package:note_firebase/view/home_screen.dart';
import 'package:note_firebase/view/splash_screen.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';

class ReadNoteScreen extends StatelessWidget {
  ReadNoteScreen({super.key, this.noteData, required this.id});
  final String id;
  // ignore: prefer_typing_uninitialized_variables
  final noteData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SpeedDial(
        speedDialChildren: <SpeedDialChild>[
          SpeedDialChild(
            child: const Icon(Icons.delete),
            foregroundColor: Colors.white,
            backgroundColor: Colors.red,
            label: 'Delete',
            onPressed: () {
              showDialog<void>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text(
                      'Delete note',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: const <Widget>[
                          Text(
                            'This note will be deleted',
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      ElevatedButton(
                        child: const Text('Decline'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text(
                          'Yes',
                          style: TextStyle(color: Colors.red),
                        ),
                        onPressed: () {
                          deleteNote(id);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SplashScreen()));
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.edit),
            foregroundColor: Colors.white,
            backgroundColor: Colors.cyan,
            label: 'Edit',
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditNoteScreen(
                          title: noteData['note_title'],
                          date: noteData['creation_date'],
                          content: noteData['note_content'],
                          id: id)));
            },
          ),
        ],
        closedForegroundColor: Colors.black,
        openForegroundColor: Colors.white,
        closedBackgroundColor: Colors.white,
        openBackgroundColor: Colors.black,
        child: const Icon(Icons.menu),
      ),
      backgroundColor: Colors.black,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomeScreen()));
              },
              icon: const Icon(Icons.arrow_back))
        ],
        backgroundColor: Colors.black45,
        title: Text(noteData['note_title']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Date: ${noteData['creation_date']}',
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              noteData['note_content'],
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  void deleteNote(String id) {
    FirebaseFirestore.instance.collection('Notes').doc(id).delete();
    log('deleted $id');
  }
}
