import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:reactivate/utils/uploader.dart';

class FilePickerDemo extends StatefulWidget {
  @override
  _FilePickerDemoState createState() => new _FilePickerDemoState();
}

class _FilePickerDemoState extends State<FilePickerDemo> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _fileName;
  String _path;
  Map<String, String> _paths;
  String _extension;
  bool _loadingPath = false;
  bool _multiPick = false;
  FileType _pickingType = FileType.any;
  TextEditingController _controller = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => _extension = _controller.text);
  }

  void _openFileExplorer() async {
    setState(() => _loadingPath = true);
    try {
      if (_multiPick) {
        _path = null;
        _paths = await FilePicker.getMultiFilePath(
            type: _pickingType,
            allowedExtensions: (_extension?.isNotEmpty ?? false)
                ? _extension?.replaceAll(' ', '')?.split(',')
                : null);
      } else {
        _paths = null;
        _path = await FilePicker.getFilePath(
            type: _pickingType,
            allowedExtensions: (_extension?.isNotEmpty ?? false)
                ? _extension?.replaceAll(' ', '')?.split(',')
                : null);
      }
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    }
    if (!mounted) return;
    setState(() {
      _loadingPath = false;
      _fileName = _path != null
          ? _path.split('/').last
          : _paths != null ? _paths.keys.toString() : '...';
    });
  }

  void _clearCachedFiles() {
    FilePicker.clearTemporaryFiles().then((result) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          backgroundColor: result ? Colors.green : Colors.red,
          content: Text((result
              ? 'Temporary files removed with success.'
              : 'Failed to clean temporary files')),
        ),
      );
    });
  }
/*
  void _selectFolder() {
    FilePicker.getDirectoryPath().then((value) {
      setState(() => _path = value);
    });
  }
*/
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text('Cargar protocolo'),
        ),
        body: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ConstrainedBox(
                      constraints: BoxConstraints.tightFor(width: 100.0),
                      child: _pickingType == FileType.custom
                          ? TextFormField(
                        maxLength: 15,
                        autovalidate: true,
                        controller: _controller,
                        decoration:
                        InputDecoration(labelText: 'File extension'),
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.none,
                      )
                          : Container(),
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints.tightFor(width: 200.0),
                      child: SwitchListTile.adaptive(
                        title: Text('Varios archivos',
                            textAlign: TextAlign.right),
                        onChanged: (bool value) =>
                            setState(() => _multiPick = value),
                        value: _multiPick,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 50.0, bottom: 20.0),
                      child: Column(
                        children: <Widget>[
                          RaisedButton(
                            onPressed: () => _openFileExplorer(),
                            child: Text("Seleccionar Archivos"),
                          ),
                          RaisedButton(
                            onPressed: () => _clearCachedFiles(),
                            child: Text("Clear temporary files"),
                          ),
                        ],
                      ),
                    ),
                    Builder(
                      builder: (BuildContext context) => _loadingPath
                          ? Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: const CircularProgressIndicator())
                          : _path != null || _paths != null
                          ? Container(
                        padding: const EdgeInsets.only(bottom: 30.0),
                        height: MediaQuery.of(context).size.height * 0.50,
                        child: Scrollbar(
                            child: ListView.separated(
                              itemCount: _paths != null && _paths.isNotEmpty
                                  ? _paths.length
                                  : 1,
                              itemBuilder: (BuildContext context, int index) {
                                final bool isMultiPath =
                                    _paths != null && _paths.isNotEmpty;
                                final String name = 'File $index: ' +
                                    (isMultiPath
                                        ? _paths.keys.toList()[index]
                                        : _fileName ?? '...');
                                final path = isMultiPath
                                    ? _paths.values.toList()[index].toString()
                                    : _path;

                                return Wrap(
                                  children: <Widget>[
                                    Text(name),
                                    Uploader(
                                      file: File(path),
                                      path: path, nit: "nitPrueba",
                                    ),


                                  ],


                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                              Divider(),
                            )),
                      )
                          : Container(),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}

/*
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';
import 'package:reactivate/utils/uploader.dart';

class FilePickerDemo extends StatefulWidget {
  @override
  _FilePickerDemoState createState() => _FilePickerDemoState();
}

class _FilePickerDemoState extends State<FilePickerDemo> {
  String _fileName;
  String _path;
  Map<String, String> _paths;
  String _extension = '';
  bool _loadingPath = false;
  bool _multiPick = false;
  FileType _pickingType = FileType.any;

  void _openFileExplorer() async {
    setState(() => _loadingPath = true);
    try {
      if (_multiPick) {
        _path = null;
        _paths = await FilePicker.getMultiFilePath(
            type: _pickingType, allowedExtensions: [_extension]);
      } else {
        _paths = null;
        _path = await FilePicker.getFilePath(
            type: _pickingType, allowedExtensions: [_extension]);
      }
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    }
    if (!mounted) return;
    setState(() {
      _loadingPath = false;
      _fileName = _path != null
          ? _path.split('/').last
          : _paths != null ? _paths.keys.toString() : '...';
    });
  }

  @override
  Widget build(BuildContext context) {
    //var polizaObj = Provider.of<Poliza>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Prueba"),),
      body: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ///Pick multiplefiles selector
                  ConstrainedBox(
                    constraints: BoxConstraints.tightFor(width: 200.0),
                    child: SwitchListTile.adaptive(
                      title: Text('Varios archivos', textAlign: TextAlign.right),
                      onChanged: (bool value) =>
                          setState(() => _multiPick = value),
                      value: _multiPick,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadiusDirectional.circular(10.0)),
                      //REVISAR ESTE COLOR
                      color: Colors.red,//amarilloSolidaria1,
                      onPressed: () => _openFileExplorer(),
                      child: Text("Seleccionar archivos",style: TextStyle(color: Colors.white),),
                    ),
                  ),
                  Builder(
                    builder: (BuildContext context) => _loadingPath
                        ? Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Text("Que pasa"))//const CircularProgressIndicator())
                        : _path != null || _paths != null
                        ? Container(
                      padding: const EdgeInsets.only(bottom: 30.0),
                      height: MediaQuery.of(context).size.height * 0.50,
                      child: Scrollbar(
                          child: ListView.separated(
                            itemCount: _paths != null && _paths.isNotEmpty
                                ? _paths.length
                                : 1,
                            itemBuilder: (BuildContext context, int index) {
                              final bool isMultiPath = _paths != null && _paths.isNotEmpty;
                              final String name = (isMultiPath ? _paths.keys.toList()[index] : _fileName ?? '...');
                              final path = isMultiPath ? _paths.values.toList()[index].toString() : _path;

                              return ListTile(
                                title: Wrap(
                                  alignment: WrapAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(name),
                                    //Add nit option to load the file under the company user
                                    Uploader(
                                      file: File(path),
                                      path: path, nit: "nitPrueba",
                                    ),
                                  ],
                                ),
                              );
                              /*
                                    return Column(
                                      children: <Widget>[
                                        ListTile(
                                          title: Text(
                                            name,
                                          ),
                                          subtitle: Text(path),
                                        ),
                                        RaisedButton(
                                            child: Text("Abrir Csv"),
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          LoadAndViewCsvPage(
                                                              path: path)));
                                            }),
                                        Uploader(
                                          file: File(path),
                                          path: path,
                                        )

                                      ],
                                    );
                                    */
                            },
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                Divider(),
                          )),
                    )
                        : Container(),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
*/