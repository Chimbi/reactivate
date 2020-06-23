import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reactivate/utils/db.dart';
//import 'package:url_launcher/url_launcher.dart';

class Uploader extends StatefulWidget {
  final File file;
  String path;
  String nit;

  Uploader({Key key, this.file, this.path, this.nit}) : super(key: key);

  @override
  _UploaderState createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {
  StorageUploadTask _uploadTask;
  String _fileName;
  StorageReference docRef;
  String url;
  int showDocument = 1;

  Future<StorageReference> _startUpload(String path, FirebaseUser user) async{
    var url;
    _fileName = path != null ? path.split('/').last : '...';
    String filePath = 'docSoporte/${widget.nit}/$_fileName';
    final FirebaseStorage _storage = FirebaseStorage(storageBucket: 'gs://appsolidaria.appspot.com/');
    StorageReference storageRef = _storage.ref().child(filePath);
    setState(() {
      _uploadTask = storageRef.putFile(widget.file);
    });
    return storageRef;
  }




  @override
  Widget build(BuildContext context) {
    var user = Provider.of<FirebaseUser>(context);
    if (_uploadTask != null) {
      return StreamBuilder<StorageTaskEvent>(
          stream: _uploadTask.events,
          builder: (context, snapshot){
            var event = snapshot?.data?.snapshot;
            double progressPercent = event != null
                ? event.bytesTransferred / event.totalByteCount
                : 0;
            if(_uploadTask.isComplete){
              docRef.getDownloadURL().then((val) {
                url = val;
                DatabaseService().setUpload(val, widget.nit, _fileName);
              });
            }
            return Column(children: <Widget>[
              if (_uploadTask.isComplete)
                Row(
                  children: <Widget>[
                    showDocument == 1 ? Wrap(
                      children: <Widget>[
                        Text(
                          " 100% ", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "🎉", style: TextStyle(fontSize: 30.0),
                        ),
                      ],
                    ):Text("Borrado"),
                    IconButton(icon: Icon(Icons.delete),onPressed: () => docRef.delete().then((_) async {
                      await DatabaseService().deleteUpload(widget.nit, _fileName);
                      setState(() {
                        showDocument = 0;
                      });
                    }).catchError((error){
                      print("Error $error");
                    }),),
                  ],
                ),
              if (_uploadTask.isInProgress)
                CircularProgressIndicator(),
              //LinearProgressIndicator(value: progressPercent),
              //Text('${(progressPercent*100).toStringAsFixed(2)} %',style: TextStyle(fontSize: 20.0),),
            ]);
          });
    } else {
      return FlatButton.icon(
          onPressed: () async => await _startUpload(widget.path, user).then((val) async {
            docRef = val;
            //DatabaseService().setUpLoad(url, widget.polizaId, _fileName);
          }),
          icon: Icon(Icons.cloud_upload),
          label: Text("Subir"));
    }
  }
}
