import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note_firebase/view/home_screen.dart';

class EditNoteScreen extends StatefulWidget {
  EditNoteScreen({
    super.key,
    required this.id,
    required this.title,
    required this.date,
    required this.content,
  });
  String title;
  String date;
  String content;
  String id;

  @override
  State<EditNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<EditNoteScreen> {
  //final dateController = DateTime.now().toString();
  final GlobalKey<FormState> formKey = GlobalKey();
  final CollectionReference noteData =
      FirebaseFirestore.instance.collection('Notes');
  late TextEditingController titleController;
  late TextEditingController contentController;
  late TextEditingController dateController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.title);
    contentController = TextEditingController(text: widget.content);
    dateController = TextEditingController(text: widget.date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: const Text('Edit your note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Title',
                  ),
                  controller: titleController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'fill';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text('date'),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'type your content',
                  ),
                  controller: contentController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'fill';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton.icon(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            updateUsers(widget.id);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomeScreen()));
                          }
                        },
                        icon: const Icon(Icons.done),
                        label: const Text('update')),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void updateUsers(String id) {
    final data = {
      'note_title': titleController.text,
      'note_content': contentController.text,
      'creation_date': dateController.text,
    };
    noteData.doc(id).update(data);
    log('updated $id');
  }
}
