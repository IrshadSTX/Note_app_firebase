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
            MaterialPageRoute(builder: (context) => const AddNoteScreen()),
          );
        },
        label: const Text('Add Note'),
        icon: const Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text('My notes'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("Notes")
                .orderBy('creation_date', descending: true)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasData) {
                if (snapshot.data!.docs.isNotEmpty) {
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                    ),
                    itemBuilder: (context, index) {
                      final DocumentSnapshot noteSnap =
                          snapshot.data!.docs[index];
                      return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: NoteCardWidget(
                              noteSnap: noteSnap, id: noteSnap.id));
                    },
                    itemCount: snapshot.data!.docs.length,
                  );
                } else {
                  return const Center(
                    child: Text(
                      'There is no notes',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }
              }
              return const Center(
                child: Text(
                  'There is no notes',
                  style: TextStyle(color: Colors.white),
                ),
              );
            },
          )),
    );
  }
}
