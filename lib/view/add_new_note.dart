import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({
    super.key,
  });

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final GlobalKey<FormState> formKey = GlobalKey();

  final TextEditingController titleController = TextEditingController();

  final TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final dateController = DateFormat('yyyy-MM-dd').format(DateTime.now());
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
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
          icon: const Icon(Icons.done),
          label: const Text('Save')),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Create your note'),
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
                  maxLength: 10,
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
                Text(dateController),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  controller: contentController,
                  decoration: const InputDecoration.collapsed(
                      hintText: 'type your text here'),
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
                  children: [],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
