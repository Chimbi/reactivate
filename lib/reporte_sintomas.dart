import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reactivate/models/empleado.dart';
import 'package:reactivate/utils/db.dart';
import 'package:provider/provider.dart';

enum SiNo { Si, No }

class ReporteSintomas extends StatefulWidget {
  @override
  _ReporteSintomasState createState() => _ReporteSintomasState();
}

class _ReporteSintomasState extends State<ReporteSintomas> {

  List<String> siNoOpcion = [
    "Si",
    "No"
  ];

  List<String> sintomasList = [
    "Fiebre (más de 37.3)",
    "Dolor de garganta",
    "Congestión nasal",
    "Tos",
    "Dificultad para respirar",
    "Fatiga",
    "Escalofrío",
    "Dolor de músculos",
    "He estado en contacto con personas infectadas con el COVID-19",
  ];
  //En este momento me encuentro en teletrabajo

  static Map<String, bool> mapRepDiario = {
    "Fiebre (más de 37.3)": false,
    "Dolor de garganta": false,
    "Congestión nasal": false,
    "Tos": false,
    "Dificultad para respirar": false,
    "Fatiga": false,
    "Escalofrío": false,
    "Dolor de músculos": false,
    "He estado en contacto con personas infectadas con el COVID-19": false,
    "Trabaja desde la casa": false
  };

  String teletrabajo;
  static Empleado empleado = Empleado(mapSintomas: mapRepDiario);

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
            sliver: SliverToBoxAdapter(
              child: Text("Reporta usted alguno de los siguientes sintomas?",style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),textAlign: TextAlign.center,),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(20.0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) => _buildList(context, sintomasList[index], empleado),
                  childCount: sintomasList.length),),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(15.0),
            sliver: SliverToBoxAdapter(
              child: Text("Trabaja desde casa?",style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),textAlign: TextAlign.center,),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(20.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                DropdownButtonFormField<String>(
                  validator: (val) => val == null ? "Campo obligatorio" : null,
                  decoration: InputDecoration(labelText: "Teletrabajo"),
                  //hint: Text("Tipo Perfil"),
                  value: teletrabajo,
                  onChanged: (newValue) => {
                    setState(() {
                      teletrabajo = newValue;
                      if(newValue == "Si"){
                        mapRepDiario.update("Trabaja desde la casa", (_) => true);
                      } else mapRepDiario.update("Trabaja desde la casa", (_) => false);
                    })
                  },
                  items: siNoOpcion.map((value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                )
              ]),

            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.all(8.0),
            sliver: SliverToBoxAdapter(
              child: Center(
                child: RaisedButton(
                  color: Colors.blue,
                  onPressed: () => handleSubmit(user, mapRepDiario),  //handleSubmit,
                  child: Text("Enviar",style: TextStyle(color: Colors.white),),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
  /*
  handleSubmit() {
    final FormState form = formKey.currentState;
    if (form != null && form.validate()) {
      debugPrint("Form validated");
      setState(() {
        form.save();
        //form.reset();

        DatabaseService().setProd(empleado.toMap()).then((_) {
          Navigator.of(context).pop();
        });
      });
    }
  }

   */


  Widget _buildList(BuildContext context, String texto, Empleado empleado) {
    return MyStatefulWidget(texto, mapRepDiario);
  }

  handleSubmit(FirebaseUser user, Map<String, bool> map) {
    DatabaseService().setRepDiario(map, user).then((_) {
      Navigator.pop(context);
    });
  }

}

class MyStatefulWidget extends StatefulWidget {
  String texto;
  Map<String, bool> repDiario;
  MyStatefulWidget(this.texto, this.repDiario);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  SiNo _sintoma = SiNo.No;

  static Map<String, bool> map = {
    "Diabetes": false,
    "Enfermedades Cardiovasculares":false,
    "Hipertensión Arterial HTA":false,
    "Accidente Cardiovascular ACV":false,
    "Enfermedades Inmunosupresoras":false,
    "Enfermedades Respiratorias":false,
  };

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(child: Text(widget.texto,style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),)),
          Expanded(
            child: Row(
              children: <Widget>[
                Text("Si"),
                Radio(
                  value: SiNo.Si,
                  groupValue: _sintoma,
                  onChanged: (SiNo value) {
                    setState(() {
                      print("Valor sintomas Si: ${value}");
                      widget.repDiario.update(widget.texto, (_) => true);
                      _sintoma = value;
                    });
                  },
                ),
                Text("No"),
                Radio(
                  value: SiNo.No,
                  groupValue: _sintoma,
                  onChanged: (SiNo value) {
                    setState(() {
                      widget.repDiario.update(widget.texto, (_) => false);
                      _sintoma = value;
                    });
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}