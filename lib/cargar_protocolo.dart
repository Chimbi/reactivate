import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reactivate/file_picker.dart';
import 'package:reactivate/temporal.dart';
import 'package:reactivate/utils/db.dart';

class CargarProtocolo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<FirebaseUser>(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            iconTheme: new IconThemeData(color: Theme.of(context).accentColor),
            elevation: 20.0,
            backgroundColor: Colors.white,
            snap: true,
            floating: true,
            expandedHeight: 80.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset(
                  'assets/logo_bogota.png',
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(15.0),
            sliver:   SliverToBoxAdapter(
              child: Text("Haz click en el botón para cargar el archivo de protocolo de la empresa",style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),textAlign: TextAlign.center,),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(8.0),
            sliver: SliverToBoxAdapter(
              child: Container(
                alignment: Alignment.center,
                child: RaisedButton(
                  color: Colors.blue,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => FilePickerDemo()));
                  },
                  child: Text("Cargar archivo",style: TextStyle(color: Colors.white),),
                ),
              ),
            ),
          )

        ],
      ),
    );
  }
}
