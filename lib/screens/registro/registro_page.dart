import 'package:flutter/material.dart';
import 'package:kimirina_app/models/ciudades_model.dart';
import 'package:kimirina_app/models/generos_model.dart';
import 'package:kimirina_app/routes/routes.dart';
import 'package:kimirina_app/colors/colors.dart';
import 'package:line_icons/line_icons.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  //Ciudades
  List<Ciudad> _cities = Ciudad.getCiudades();
  List<DropdownMenuItem<Ciudad>> _dropdownMenuItems;
  Ciudad _selectedCity;
  var _comboBoxColor = Colors.black;

  //Generos
  List<Genero> _genre = Genero.getGeneros();
  List<DropdownMenuItem<Genero>> _dropdownMenuGeneroItems;
  Genero _selectedGenre;
  var _comboBoxColorDos = Colors.black;

   @override
  void initState() {
    _dropdownMenuItems =  buildDropdownMenuItems(_cities);
    _selectedCity = _dropdownMenuItems[0].value;
    _dropdownMenuGeneroItems = buildDropdownMenuGeneroItems(_genre);
    _selectedGenre = _dropdownMenuGeneroItems[0].value;
    super.initState();
  }
   List<DropdownMenuItem<Ciudad>> buildDropdownMenuItems(List cities) {
    List<DropdownMenuItem<Ciudad>> items = List();
    for (Ciudad city in cities) {
      items.add(
        DropdownMenuItem(
          value: city,
          child: Text(city.nombre),
        ),
      );
    }
    return items;
  }

  List<DropdownMenuItem<Genero>> buildDropdownMenuGeneroItems(List genres) {
    List<DropdownMenuItem<Genero>> items = List();
    for (Genero genre in genres) {
      items.add(
        DropdownMenuItem(
          value: genre,
          child: Text(genre.nombre),
        ),
      );
    }
    return items;
  }



  @override
  Widget build(BuildContext context) {
    final appBar = Padding(
      padding: EdgeInsets.only(bottom: 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          )
        ],
      ),
    );

    final pageTitle = Container(
      child: Text(
        "Crea una nueva cuenta",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 40.0,
        ),
      ),
    );

    final formFieldSpacing = SizedBox(
      height: 30.0,
    );

    final registerForm = Padding(
      padding: EdgeInsets.only(top: 30.0),
      child: Form(
        child: Column(
          children: <Widget>[
            _buildFormField('Username', LineIcons.user,TextInputType.text, true),
            formFieldSpacing,
            _buildFormField('E-mail', LineIcons.newspaper_o,TextInputType.emailAddress, true),
            formFieldSpacing,
            _buildFormField('Fecha de nacimiento', LineIcons.calendar,TextInputType.datetime, true),
            formFieldSpacing,
          ],
        ),
      ),
    );
    final gender = Padding(
     padding: EdgeInsets.only(top:0.0),
      child: Row(
        children: <Widget>[
                Icon(Icons.wc),
                Text("Genero: ",style: TextStyle(color: Colors.black),),
                SizedBox(width: 30.0,),
                DropdownButton(        
                  value: _selectedGenre,
                  items: _dropdownMenuGeneroItems,
                  onChanged: onChangeDropdownGeneroItem,
                  style: TextStyle(color: _comboBoxColorDos),
                ),
            formFieldSpacing,
        ],
      ),
    );
    final city = Padding(
      padding: EdgeInsets.only(top:0.0),
      child: Row(
        children: <Widget>[
                Icon(Icons.home),
                Text("Ciudad: ",style: TextStyle(color: Colors.black),),
                SizedBox(width: 30.0,),
                DropdownButton(        
                  value: _selectedCity,
                  items: _dropdownMenuItems,
                  onChanged: onChangeDropdownItem,
                  style: TextStyle(color: _comboBoxColor),
                ),
            formFieldSpacing,
        ],
      ),

    );
    final submitBtn = Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: Container(
        margin: EdgeInsets.only(top: 10.0, bottom: 20.0),
        height: 60.0,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7.0),
          border: Border.all(color: Colors.pinkAccent),
        ),
        child: Material(
          borderRadius: BorderRadius.circular(7.0),
          color: Colors.orangeAccent[200],
          elevation: 10.0,
          shadowColor: Colors.pinkAccent[100],
          child: MaterialButton(
            onPressed: () => Navigator.of(context).pushNamed(loginViewRoute),
            child: Text(
              'Registrarse',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 40.0),
          decoration: BoxDecoration(gradient: primaryGradient),
          child: Column(
            children: <Widget>[
              appBar,
              Container(
                padding: EdgeInsets.only(left: 30.0, right: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    pageTitle,
                    registerForm,
                    gender,
                    city,
                    submitBtn
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormField(String label, IconData icon, TextInputType type, bool isEnabled) {
    return TextFormField(
      enabled: isEnabled,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.black),
        prefixIcon: Icon(
          icon,
          color: Colors.black38,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black38),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: primaryColor),
        ),
      ),
      keyboardType: type,
      style: TextStyle(color: Colors.black),
      cursorColor: Colors.black,
    );
  }

  //OnChange
  onChangeDropdownItem(Ciudad selectedCity) {
    setState(() {
      _selectedCity = selectedCity;
      _comboBoxColor = primaryColor;
    });
  }

  onChangeDropdownGeneroItem(Genero selectedGenre) {
    setState(() {
      _selectedGenre = selectedGenre;
      _comboBoxColorDos = primaryColor;
    });
  }
}
