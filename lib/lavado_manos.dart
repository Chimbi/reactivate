import 'package:flutter/material.dart';

class LavadoManos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            sliver: SliverToBoxAdapter(
              child: Text("Haz click en el botón cada vez que te laves las manos",style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),textAlign: TextAlign.center,),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(8.0),
            sliver: SliverToBoxAdapter(
              child: Container(
                alignment: Alignment.center,
                child: RaisedButton(
                  color: Colors.blue,
                  onPressed: () {},
                  child: Text("Me lave las manos",style: TextStyle(color: Colors.white),),
                ),
              ),
            ),
          )

        ],
      ),
    );
  }
}
