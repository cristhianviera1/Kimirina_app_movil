class Genero {
  int id;
  String nombre;
 
  Genero(this.id, this.nombre);
 
  static List<Genero> getGeneros() {
    return <Genero>[
      Genero(1, 'Maculino'),
      Genero(2, 'Femenino'),
      Genero(3, 'Trans'),
      Genero(4, 'SCH'),
      Genero(5, 'Gabriel'),
      Genero(6, 'Maricon'),
    ];
  }
}