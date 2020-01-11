class Ciudad {
  int id;
  String nombre;
 
  Ciudad(this.id, this.nombre);
 
  static List<Ciudad> getCiudades() {
    return <Ciudad>[
      Ciudad(1, 'Quito'),
      Ciudad(2, 'Guayaquil'),
      Ciudad(3, 'Cuenca'),
      Ciudad(4, 'Esmeraldas'),
      Ciudad(5, 'Portoviejo'),
      Ciudad(6, 'Machala'),
    ];
  }
}