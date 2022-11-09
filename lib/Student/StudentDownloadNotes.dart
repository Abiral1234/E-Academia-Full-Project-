import 'package:flutter/material.dart';

import '../Colors.dart';
class StudentDownloadNotes extends StatefulWidget {
  const StudentDownloadNotes({Key? key}) : super(key: key);

  @override
  State<StudentDownloadNotes> createState() => _StudentDownloadNotesState();
}

class _StudentDownloadNotesState extends State<StudentDownloadNotes> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: lightBlue.withOpacity(0.2),
        child:
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10,20,10,10),
                child: Text("Downloads:",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
              ),
              Card(
                child: ListTile(
                  onTap: (){
                    setState(() {});

                  },
                  title: Text("Engineering Economics"),
                  subtitle: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text("Text Book"),
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  onTap: (){
                    setState(() {});

                  },
                  title: Text("Engineering Economics"),
                  subtitle: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text("Text Book"),
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  onTap: (){
                    setState(() {});

                  },
                  title: Text("Engineering Economics"),
                  subtitle: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text("Text Book"),
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  onTap: (){
                    setState(() {});

                  },
                  title: Text("Engineering Economics"),
                  subtitle: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text("Text Book"),
                  ),
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
