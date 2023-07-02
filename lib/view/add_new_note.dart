import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddNoteScreen extends StatefulWidget {
  AddNoteScreen({
    super.key,
  });

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final dateController = DateTime.now().toString();

  final GlobalKey<FormState> formKey = GlobalKey();

  final TextEditingController titleController = TextEditingController();

  final TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Create your note'),
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
                SizedBox(
                  height: 20,
                ),
                Text(
                  dateController,
                ),
                SizedBox(
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
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton.icon(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            FirebaseFirestore.instance.collection('Notes').add({
                              "note_title": titleController.text,
                              "note_content": contentController.text,
                              "creation_date": dateController
                            }).then((value) {
                              Navigator.pop(context);
                            }).catchError((error) => log('failed$error'));
                          }
                        },
                        icon: Icon(Icons.done),
                        label: Text('Save')),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
