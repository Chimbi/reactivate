import 'package:flutter/material.dart';
import 'package:reactivate/login.dart';
import 'package:reactivate/utils/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MenuRoute {
  const MenuRoute(this.name, this.route, this.widget);

  final widget;
  final String name;
  final String route;
}

const Color hintCol = Color(0xff003f75);//;
const Color colorIcono = Colors.amber;

final List<MenuRoute> menu = <MenuRoute>[
  MenuRoute("Resumen", '/empleado', Icon(Icons.report, size: 40.0, color: colorIcono)),
  MenuRoute("Cuadro de control", '/sintomas', Icon(Icons.people, size: 40.0, color: colorIcono)),
  MenuRoute("Reporte caso COVID-19", '/manos', Icon(Icons.local_hospital, size: 40.0, color: colorIcono)),
  MenuRoute("Reporte cuarentena", '/movimientos', Icon(Icons.home, size: 40.0, color: colorIcono)),
  MenuRoute("Registro de comunicacion", '/movimientos', Icon(Icons.phone, size: 40.0, color: colorIcono)),
  MenuRoute("Cargar Protocolo de la empresa", '/protocolo', Icon(Icons.insert_drive_file, size: 40.0, color: colorIcono)),
];



class MenuEncargado extends StatefulWidget {
  @override
  _MenuEncargadoState createState() => _MenuEncargadoState();
}

class _MenuEncargadoState extends State<MenuEncargado> {
  @override
  Widget build(BuildContext context) {
    final drawerHeader = UserAccountsDrawerHeader(
        accountEmail: Text("user.email"),
        accountName: Text("Cuenta"),
        //accountEmail: polizaObj.intermediary != null ? Text('${polizaObj.intermediary.email}'): Container(),
        currentAccountPicture: CircleAvatar(
          child: Image.asset('assets/logo_bogota.png'),
          backgroundColor: Colors.white,
        )
    );
    final drawerItems = ListView(
      children: <Widget>[
        drawerHeader,
        ListTile(
            title: Text('Pedido nuevo'),
            onTap: () => {}//Navigator.pushNamed(context, '/pedido'),
        ),
        /*
        ListTile(
            title: Text('Historico'),
            onTap: () => Navigator.pushNamed(context, '/polizas')
        ),
        ListTile(
          title: Text('Control Técnico'),
          onTap: () => DatabaseService().checkAutorization(context, polizaObj),//Navigator.pushNamed(context, '/control')
        ),
        */
        ListTile(
            title: Text('Salir'),
            onTap: () {
              auth.signOut(context);
              //Navigator.popUntil(context, ModalRoute.withName('/login'));
              Navigator.pop(context);
              Navigator.pop(context);
            }//Navigator.pushNamed(context, '/profile')
        ),
      ],
    );
    return Scaffold(
      floatingActionButton: FloatingActionButton(backgroundColor: Colors.red[700], child: Icon(Icons.pan_tool, color: Colors.white,), onPressed: (){
        Navigator.pushNamed(context, '/manos');
      },),
      drawer: Drawer(
        elevation: 10.0,
        child: drawerItems,
      ),
      // SliverAppBar is declared in Scaffold.body, in slivers of a
      // CustomScrollView.
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
          // If the main content is a list, use SliverList instead.
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context,index) => _buildTitle(context, menu[index]),
              childCount: menu.length,
            ),
          )
        ],
      ),
    );
  }
  Widget _buildTitle(BuildContext context, MenuRoute menu) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
          children: <Widget>[
            InkWell(
              onTap: () async {
                Navigator.pushNamed(context, menu.route);
              },
              child: Card(
                  elevation: 7.0,
                  margin: EdgeInsets.all(5.0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Container(
                    decoration: BoxDecoration(
                        boxShadow: [BoxShadow(
                            blurRadius: 20.0,
                            offset: Offset(8, 8),
                            color: Colors.black54
                        )],
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        gradient: LinearGradient(
                          colors: [Colors.blue[700], Colors.blue], //hintCol
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        )
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              "${menu.name}",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold), textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        menu.widget
                      ],
                    ),
                  )),
            ),
          ]
      ),
    );
  }
}


/*
class PaginaInicio extends StatelessWidget {
  final AuthService auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Esto es una prueba'),
      ),
      body: Column(
        children: <Widget>[
          Text("Salir"),
          RaisedButton(child: Text("Salir"), onPressed: () {
            //Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
            auth.signOut(context);
            Navigator.pop(context);
          })
        ],
      ),
    );
  }
}
*/