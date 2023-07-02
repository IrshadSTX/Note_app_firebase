import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note_firebase/view/add_new_note.dart';
import 'package:note_firebase/view/widgets/note_container.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton.extended(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddNoteScreen()),
          );
        },
        label: Text('Add Note'),
        icon: Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text('My notes'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("Notes").snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: LinearProgressIndicator());
              }
              if (snapshot.hasData) {
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    final DocumentSnapshot noteSnap =
                        snapshot.data!.docs[index];
                    return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: NoteCardWidget(noteSnap: noteSnap));
                  },
                  itemCount: snapshot.data!.docs.length,
                );
              }
              return Text('There is no notes');
            },
          )),
    );
  }
}
