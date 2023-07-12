import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note_firebase/view/read_note_screen.dart';

class NoteCardWidget extends StatelessWidget {
  const NoteCardWidget({
    super.key,
    required this.noteSnap,
    required this.id,
  });
  final String id;
  final DocumentSnapshot<Object?> noteSnap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushReplacement(
          context,
          (MaterialPageRoute(
              builder: (context) => ReadNoteScreen(
                    noteData: noteSnap,
                    id: id,
                  ))),
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
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                noteSnap['creation_date'],
                style: const TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 60,
                child: Text(
                  noteSnap['note_content'],
                  style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      overflow: TextOverflow.ellipsis),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
