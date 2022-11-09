
import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Colors.dart';
import 'package:eacademia/Connection/conn.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
class SubmitNotePage extends StatefulWidget {
  const SubmitNotePage({Key? key}) : super(key: key);

  @override
  State<SubmitNotePage> createState() => _SubmitNotePageState();
}

class _SubmitNotePageState extends State<SubmitNotePage> {
  @override
  // ignore: must_call_super
  void initState() {
    getToken();
  }
  String refresh_token='';
  String access_token='';

  getToken() async{
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      refresh_token = sharedPreferences.get('refresh_token').toString();
      access_token = sharedPreferences.get('access_token').toString();
    });
  }
  bool loading =false;
  bool success = false;
  File? assignmentFile;
  String fileName ='';
  TextEditingController title = new TextEditingController();
  CreateNote() async {
    setState(() {
      loading = true;
    });
    try {
      setState(() {
        loading = true;
      });

      print("Creating Notes ....");
      var uri = Uri.parse("http://$host:8000/teacher/notes/");
      var request = new http.MultipartRequest('POST', uri);
      request.headers["content-type"] = 'application/json';
      request.headers['Authorization'] ='Bearer $access_token';
      request.fields['title']=title.text;
      request.fields['subject']=jsonEncode({"id":1});
      var stream = new http.ByteStream(assignmentFile!.openRead());
      stream.cast();
      var length = await assignmentFile!.length();
      String filename = basename(assignmentFile!.path);
      var Files = new http.MultipartFile('file',
        stream,
        length ,
        filename: filename,
      );
      print(Files);
      request.files.add(Files);

      var response = await request.send();
      final data = await response.stream.bytesToString();;
      print(data);
      // var response;
      // var data = {
      //   "title":title.text,
      //   "subject": {
      //     "id": "2",
      //   },
      //   "assigned_date": assignedDate,
      //   "deadline_date": deadlineDate,
      //   "status": "submited",
      //   "file": Files
      // };
      // print(data);
      // response = await http.post(
      //     Uri.parse("http://$host:8000/teacher/assignment/"),
      //     headers: {
      //       'content-type': 'application/json',
      //       'Authorization': 'Bearer $access_token',
      //     },
      //     body: jsonEncode(data)
      // );
      // print(response.body);
      print("The Status Code is");
      print(response.statusCode);
      setState(() {
        loading = false;
        success = true;
      });
    }
    catch(e){
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Submit Note'),
        backgroundColor: blue,
        elevation: 0,
        excludeHeaderSemantics: true,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Note title",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                SizedBox(height: 10,),
                DefaultTextField("Title",title),
                SizedBox(height: 10,),
                fileName==''?Container():Card(
                  color: Colors.deepPurple,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Container(
                      width: Get.width,
                      height: 20,
                      child:Center(child: Text(fileName,style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),)) ,
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: green,
                  ),
                  child: ListTile(
                    onTap: () async{
                      // final result = await FilePicker.platform.pickFiles(allowMultiple: true);
                      final result = await FilePicker.platform.pickFiles();
                      if(result == null) return;
                      setState(() {
                        final file = result.files.first ;
                        fileName = file.name;
                        assignmentFile = File(file.path!);
                        print(file.size);
                        print(file.extension);
                        print("The file name is "+ fileName);
                      });
                    },
                    leading: FaIcon(FontAwesomeIcons.upload,color: white,size: 30,),
                    title: Text("Upload Note",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: white),),
                    subtitle: Text("Attach Note",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: white),),
                  ),
                ),
                SizedBox(height: 20,),
                ElevatedButton(
                    onPressed: (){CreateNote();},
                    child: Text("Submit",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
Widget DefaultTextField(String hintText, TextEditingController controller){
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: grey5),
      borderRadius: BorderRadius.circular(5),
    ),
    child: TextField(
      controller: controller,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(10,0,0,0),
        border: InputBorder.none,
        fillColor: Colors.white,
        hintText: hintText,
        hintStyle: TextStyle(color: grey3),
      ),
    ),
  );
}