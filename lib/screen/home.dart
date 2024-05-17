import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:apptodolist/screen/add_note_screen.dart';
import 'package:apptodolist/widgets/stream_note.dart';
import 'package:apptodolist/data/firestor.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({Key? key}) : super(key: key);

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  bool show = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      floatingActionButton: Visibility(
        visible: show,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Add_creen(),
            ));
          },
          backgroundColor: Color(0xff18DAA3),
          child: Icon(Icons.add, size: 30),
        ),
      ),
      body: SafeArea(
        child: NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            if (notification.direction == ScrollDirection.forward) {
              setState(() {
                show = true;
              });
            } else if (notification.direction == ScrollDirection.reverse) {
              setState(() {
                show = false;
              });
            }
            return true;
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                Consumer<FirestoreDatasource>(
                  builder: (context, firestoreDatasource, _) {
                    return Stream_note(
                      false,
                      firestoreDatasource: firestoreDatasource,
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'isDone',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Consumer<FirestoreDatasource>(
                  builder: (context, firestoreDatasource, _) {
                    return Stream_note(
                      true,
                      firestoreDatasource: firestoreDatasource,
                    );
                  },
                ),
                SizedBox(height: 16), // Ajout d'un espace entre les deux listes
              ],
            ),
          ),
        ),
      ),
    );
  }
}
