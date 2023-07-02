import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note_firebase/view/edit_screen.dart';
import 'package:note_firebase/view/read_note_screen.dart';

class NoteCardWidget extends StatelessWidget {
  const NoteCardWidget({
    super.key,
    required this.noteSnap,
  });

  final DocumentSnapshot<Object?> noteSnap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          (MaterialPageRoute(
              builder: (context) => ReadNoteScreen(noteData: noteSnap))),
        );
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white, width: 1)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                noteSnap['note_title'],
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                noteSnap['creation_date'],
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                noteSnap['note_content'],
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    overflow: TextOverflow.ellipsis),
              ),
            )
          ],
        ),
      ),
    );
  }
}
