import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:apptodolist/widgets/task_widgets.dart';
import '../data/firestor.dart';

class Stream_note extends StatelessWidget {
  final bool done;
  final FirestoreDatasource firestoreDatasource;

  Stream_note(this.done, {required this.firestoreDatasource, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestoreDatasource.stream(done),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        final noteslist = firestoreDatasource.getNotes(snapshot);
        return ListView.builder(
          shrinkWrap: true,
          itemCount: noteslist.length,
          itemBuilder: (context, index) {
            final note = noteslist[index];
            return Dismissible(
              key: UniqueKey(),
              onDismissed: (direction) {
                firestoreDatasource.deleteNote(note.id);
              },
              child: Task_Widget(note),
            );
          },
        );
      },
    );
  }
}
