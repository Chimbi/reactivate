import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReporteMovimientos extends StatefulWidget {

  @override
  _ReporteMovimientosState createState() => _ReporteMovimientosState();
}

class _ReporteMovimientosState extends State<ReporteMovimientos> {
  TextEditingController fechaController = TextEditingController();
  TextEditingController horaController = TextEditingController();
  TextEditingController lugarController = TextEditingController();
  TextEditingController personaContacto = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    fechaController.dispose();
    horaController.dispose();
    lugarController.dispose();
    personaContacto.dispose();
    super.dispose();
  }

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
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    //Text("Fecha Rollo en objeto ${rollo.fecha}"),
                    BasicDateField(),
                    BasicTimeField(),
                    TextFormField(
                      controller: lugarController,
                      decoration: InputDecoration(labelText: 'Lugar'),
                      enabled: true,
                      onChanged: (value) =>  {}, //empleado.numCedula = int.parse(value),
                      validator: (val) => val == "" ? "Campo obligatorio" : null,
                    ),
                    TextFormField(
                      controller: personaContacto,
                      decoration: InputDecoration(labelText: 'Nombre con quien tuviste contacto'),
                      enabled: true,
                      onChanged: (value) =>  {}, //empleado.celular = int.parse(value),
                      validator: (val) => val == "" ? "Campo obligatorio" : null,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(8.0),
            sliver: SliverToBoxAdapter(
              child: Center(
                child: RaisedButton(
                  color: Colors.blue,
                  onPressed: (){},//handleSubmit,
                  child: Text("Enviar",style: TextStyle(color: Colors.white),),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}


class BasicDateField extends StatefulWidget {
  //Empleado empleado;

  BasicDateField({Key key}) : super(key: key); //, this.empleado

  @override
  _BasicDateFieldState createState() => _BasicDateFieldState();
}

class _BasicDateFieldState extends State<BasicDateField> {
  final format = DateFormat("yyyy-MM-dd");
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      DateTimeField(
        validator: (date) => date == null ? 'Fecha invalida' : null,
        onChanged: (value){
          setState((){
            //empleado.fecha = value;
            print("Fecha $value");
          });
        },
        decoration: InputDecoration(labelText: "Fecha"),
        format: format,
        onShowPicker: (context, currentValue) {
          return showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
        },
      ),
    ]);
  }
}

class BasicTimeField extends StatelessWidget {
  final format = DateFormat("hh:mm a");
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      //Text('Basic time field (${format.pattern})'),
      DateTimeField(
        format: format,
        decoration: InputDecoration(labelText: "Hora"),
        onShowPicker: (context, currentValue) async {
          final time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
          );
          return DateTimeField.convert(time);
        },
      ),
    ]);
  }
}
