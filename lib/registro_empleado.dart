import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reactivate/models/empleado.dart';
import 'package:reactivate/utils/db.dart';

class RegistroEmpleado extends StatefulWidget {
  @override
  _RegistroEmpleadoState createState() => _RegistroEmpleadoState();
}

class _RegistroEmpleadoState extends State<RegistroEmpleado> {
  String fuma;

  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  TextEditingController edadController = TextEditingController();
  TextEditingController celularController = TextEditingController();
  TextEditingController cedulaController = TextEditingController();
  TextEditingController apellidoController = TextEditingController();
  TextEditingController nombreController = TextEditingController();

  List<String> siNoOpcion = [
    "Si",
    "No"
  ];

  static Map<String, bool> map = {
    "Diabetes": false,
    "Enfermedades Cardiovasculares":false,
    "Hipertensión Arterial HTA":false,
    "Accidente Cardiovascular ACV":false,
    "Enfermedades Inmunosupresoras":false,
    "Enfermedades Respiratorias":false,
  };
  
  List<String> enfermedadesList = [
    "Diabetes",
    "Enfermedades Cardiovasculares",
    "Hipertensión Arterial HTA",
    "Accidente Cardiovascular ACV",
    "Enfermedades Inmunosupresoras",
    "Enfermedades Respiratorias",
  ];

  List<String> transporteList = [
    "Bicicleta",
    "Automovil",
    "Moto",
    "Transporte público",
    "Taxi",
    "Transporte de la empresa",
    "A pie"
  ];

  static Map<String, bool> mapTransporte = {
    "Bicicleta": false,
    "Automovil": false,
    "Moto": false,
    "Transporte público": false,
    "Taxi": false,
    "Transporte de la empresa": false,
    "A pie": false
  };

  static Empleado empleado = Empleado(mapMorbilidadEmpl: map, mapTransporte: mapTransporte);

  final GlobalKey<FormState> formKey = GlobalKey();




  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    pesoController.dispose();
    alturaController.dispose();
    edadController.dispose();
    cedulaController.dispose();
    celularController.dispose();
    apellidoController.dispose();
    nombreController.dispose();
    super.dispose();
  }

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
              child: Text("Datos básicos",style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),textAlign: TextAlign.center,),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    //Text("Fecha Rollo en objeto ${rollo.fecha}"),
                    TextFormField(
                      controller: nombreController,
                      decoration: InputDecoration(labelText: 'Nombres'),
                      enabled: true,
                      onChanged: (value) =>  empleado.nombre = value,
                      validator: (val) => val == "" ? "Campo obligatorio" : null,
                    ),
                    TextFormField(
                      controller: apellidoController,
                      decoration: InputDecoration(labelText: 'Apellidos'),
                      enabled: true,
                      onChanged: (value) =>  empleado.apellido = value,
                      validator: (val) => val == "" ? "Campo obligatorio" : null,
                    ),
                    TextFormField(
                      controller: cedulaController,
                      decoration: InputDecoration(labelText: 'Cedula'),
                      enabled: true,
                      onChanged: (value) =>  empleado.numCedula = int.parse(value),
                      validator: (val) => val == "" ? "Campo obligatorio" : null,
                    ),
                    TextFormField(
                      controller: celularController,
                      decoration: InputDecoration(labelText: 'Número Celular'),
                      enabled: true,
                      onChanged: (value) =>  empleado.celular = int.parse(value),
                      validator: (val) => val == "" ? "Campo obligatorio" : null,
                    ),
                    TextFormField(
                      controller: edadController,
                      decoration: InputDecoration(labelText: 'Edad'),
                      enabled: true,
                      onChanged: (value) =>  empleado.edad = int.parse(value),
                      validator: (val) => val == "" ? "Campo obligatorio" : null,
                    ),
                    TextFormField(
                      controller: alturaController,
                      decoration: InputDecoration(labelText: 'Altura'),
                      enabled: true,
                      onChanged: (value) =>  empleado.altura = int.parse(value),
                      validator: (val) => val == "" ? "Campo obligatorio" : null,
                    ),
                    TextFormField(
                      controller: pesoController,
                      decoration: InputDecoration(labelText: 'Peso'),
                      enabled: true,
                      onChanged: (value) =>  empleado.peso = int.parse(value),
                      validator: (val) => val == "" ? "Campo obligatorio" : null,
                    ),
                    DropdownButtonFormField<String>(
                      validator: (val) => val == null ? "Campo obligatorio" : null,
                      decoration: InputDecoration(labelText: "Fuma"),
                      //hint: Text("Tipo Perfil"),
                      value: fuma,
                      onChanged: (newValue) {
                        setState(() {
                          fuma = newValue;
                          empleado.fuma = newValue;
                        });
                      },
                      items: siNoOpcion.map((value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(15.0),
            sliver: SliverToBoxAdapter(
              child: Text("Sufre alguna de estas enfermedades?",style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),textAlign: TextAlign.center,),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(20.0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) => _buildList(context, enfermedadesList[index], empleado, "Enfermedad"),
              childCount: enfermedadesList.length),),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(15.0),
            sliver: SliverToBoxAdapter(
              child: Text("Como se moviliza al trabajo?",style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),textAlign: TextAlign.center,),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(20.0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) => _buildList(context, transporteList[index],empleado, "Transporte"),
                  childCount: transporteList.length),),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(8.0),
            sliver: SliverToBoxAdapter(
              child: Center(
                child: RaisedButton(
                  color: Colors.blue,
                  onPressed: () => handleSubmit(user),
                  child: Text("Enviar",style: TextStyle(color: Colors.white),),
                ),
              ),
            ),
          )

        ],
      ),
    );
  }

  handleSubmit(FirebaseUser user) async {
    final FormState form = formKey.currentState;
    if (form != null && form.validate()) {
      debugPrint("Form validated");
      setState(() {
        form.save();
        //form.reset();

        DatabaseService().setProd(empleado.toMap(), user).then((_) {
          Navigator.pop(context);
        });
      });
    }
  }

  Widget _buildList(BuildContext context, String texto, Empleado empleado, String tipo) {
    return MyStatefulWidget(texto,empleado,tipo);
  }
}

/*
final FormState form = formKey.currentState;
    if (form.validate()) {
      debugPrint("Form validated");
      setState(() {
        form.save();
        form.reset();
 */

// Flutter code sample for CheckboxListTile

// ![Custom checkbox list tile sample](https://flutter.github.io/assets-for-api-docs/assets/material/checkbox_list_tile_custom.png)
//
// Here is an example of a custom LabeledCheckbox widget, but you can easily
// make your own configurable widget.
class MyStatefulWidget extends StatefulWidget {
  final String texto;
  final Empleado empleado;
  final String tipo; //enfermedad, transporte
  MyStatefulWidget(this.texto, this.empleado, this.tipo);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      key: ValueKey(widget.texto),
      title: Text(widget.texto),
      value: selected,
      onChanged: (bool value) {
        //To update the map you should ignore the previous value in the parameter with (_)
        if(widget.tipo == "Enfermedad"){
          widget.empleado.mapMorbilidadEmpl.update(widget.texto, (_) => value);
        } else {
          widget.empleado.mapTransporte.update(widget.texto, (_) => value);
        }

        setState(() {
          selected = value;
          //print("widget Text: ${widget.text} Value: ${value}");
          /*
          if(widget.tipo == "Enfermedad") {
            print("Prueba de fuego: ${widget.empleado.mapMorbilidadEmpl
                .toString()}");
          } else {
            print("Prueba de fuego: ${widget.empleado.mapTransporte
                .toString()}");
          }
           */
        });
      },
      //secondary: const Icon(Icons.hourglass_empty),
    );
  }
}
