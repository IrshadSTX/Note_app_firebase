import 'package:flutter/material.dart';

class ReadNoteScreen extends StatelessWidget {
  ReadNoteScreen({super.key, this.noteData});
  final noteData;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
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
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              noteData['note_content'],
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
