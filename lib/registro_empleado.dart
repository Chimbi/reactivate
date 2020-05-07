import 'package:flutter/material.dart';
import 'package:reactivate/models/empleado.dart';
import 'package:reactivate/utils/db.dart';

class RegistroEmpleado extends StatefulWidget {
  @override
  _RegistroEmpleadoState createState() => _RegistroEmpleadoState();
}

class _RegistroEmpleadoState extends State<RegistroEmpleado> {
  Empleado empleado = Empleado();
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
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text("Registro inicial empleado"),
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
                      decoration: InputDecoration(labelText: "Tipo Rollo"),
                      //hint: Text("Tipo Perfil"),
                      value: fuma,
                      onChanged: (newValue) {
                        setState(() {
                          fuma = newValue;
                        });
                      },
                      items: siNoOpcion.map((value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    Center(
                      child: RaisedButton(
                        color: Colors.blue,
                        onPressed: handleSubmit,
                        child: Text("Enviar",style: TextStyle(color: Colors.white),),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  handleSubmit() {
    final FormState form = formKey.currentState;
    if (form != null && form.validate()) {
      debugPrint("Form validated");
      setState(() {
        form.save();
        //form.reset();
        /*
        DatabaseService().setRollo(rollo).then((_) {
          Navigator.of(context).pop();
        });

         */
      });
    }
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