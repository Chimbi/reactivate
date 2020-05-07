import 'dart:core';

class Empleado {
  String nombre;
  String apellido;
  int numCedula;
  int celular;
  int edad;
  int altura;
  int peso;
  bool fuma;
  int noPersonas;
  List<MorbilidadEmpleado> morbilidadEmpleado;
  List<MorbilidadFamilia> morbilidadFamilia;
  List<Transporte> transporte;

  Empleado({this.nombre, this.apellido, this.numCedula, this.celular, this.edad,
      this.altura, this.peso, this.fuma, this.noPersonas,
      this.morbilidadEmpleado, this.morbilidadFamilia, this.transporte});

  Map<String, dynamic> toMap(){
    return {
      "nombre": nombre,
      "apellido": apellido,
      "numCedula": numCedula,
      "celular": celular,
      "edad": edad,
      "altura": altura,
      "peso": peso,
      "fuma": fuma,
      "noPersonas": noPersonas,
    };
  }

  factory Empleado.fromMap(Map<String,dynamic> map) => Empleado(
    nombre: map["nombre"],
    apellido: map["apellido"],
    numCedula: map["numCedula"],
    celular: map["celualr"],
    edad: map["edad"],
    peso: map["peso"],
    fuma: map["fuma"],
    noPersonas: map["noPersonas"],
  );


}

class MorbilidadEmpleado {
  String enfermedad;
  bool diagnostico;

  MorbilidadEmpleado(this.enfermedad, this.diagnostico);

  toJson() {
    return {
      "enfermedad": enfermedad,
      "diagnostico": diagnostico,
    };
  }
}

class MorbilidadFamilia {
  String enfermedad;
  bool casosHogar;

  MorbilidadFamilia(this.enfermedad, this.casosHogar);

  toJson(){
    return {
      "enfermedad": enfermedad,
      "casosHogar": casosHogar,
    };
  }
}

class Transporte {
  String medioTransporte;
  bool uso;

  Transporte(this.medioTransporte, this.uso);

}

/*
bool diabetes;
bool enfCardiovascular;
bool hta;
bool acv;
bool inmunosupresoras;
bool respiratorias;
 */

