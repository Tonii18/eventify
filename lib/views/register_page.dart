import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  String? _defaultValue;
  final List<String> _list = ['Usuario', 'Organizador'];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scale = size.width / 400;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 20 * scale),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,

            // This CHILDREN ARRAY contains every components

            children: [
             
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32 * scale),

                // This ROW is the first screen section

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back),
                      color: Color.fromRGBO(97, 92, 233, 1.0),
                      iconSize: 35 * scale,
                    ),
                    Text(
                      'Crea tu cuenta',
                      style: TextStyle(
                        fontSize: 30 * scale,
                        fontWeight: FontWeight.w900,
                        color: Color.fromRGBO(97, 92, 233, 1.0),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16 * scale,),

              // IMAGE 

              Image.asset(
                'lib/assets/images/signup.png',
                width: 150 * scale,
                height: 150 * scale,
              ),

              SizedBox(height: 16 * scale,),

              // FORMS FIELDS

              SizedBox(
                width: size.width * 0.75,
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Nombre de usuario',
                    labelStyle: TextStyle(
                      color: Color.fromRGBO(180, 180, 180, 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromRGBO(180, 180, 180, 1.0)
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)
                    )
                  ),
                ),
              ),

              SizedBox(height: 16 * scale,),

              SizedBox(
                width: size.width * 0.75,
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Correo electrónico',
                    labelStyle: TextStyle(
                      color: Color.fromRGBO(180, 180, 180, 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromRGBO(180, 180, 180, 1.0),
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)
                    )
                  ),
                ),
              ),

              SizedBox(height: 16 * scale,),

              SizedBox(
                width: size.width * 0.75,
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    labelStyle: TextStyle(
                      color: Color.fromRGBO(180, 180, 180, 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromRGBO(180, 180, 180, 1.0),
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)
                    )
                  ),
                ),
              ),

              SizedBox(height: 16 * scale,),

              SizedBox(
                width: size.width * 0.75,
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Confirmar contraseña',
                    labelStyle: TextStyle(
                      color: Color.fromRGBO(180, 180, 180, 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromRGBO(180, 180, 180, 1.0),
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    )
                  ),
                ),
              ),

              SizedBox(height: 16 * scale,),

              // SELECT FIELD

              SizedBox(
                width: size.width * 0.75,
                child: DropdownButtonFormField(
                  initialValue: _defaultValue,
                  decoration: InputDecoration(
                    labelText: 'Selecciona tu rol',
                    labelStyle: TextStyle(
                      color: Color.fromRGBO(180, 180, 180, 1.0)
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromRGBO(180, 180, 180, 1.0)
                      )
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 32 * scale)
                  ),
                  items: _list.map((option) => DropdownMenuItem(value: option,child: Text(option))).toList(), 
                  onChanged: (value) {
                    setState(() {
                      _defaultValue = value;
                    });
                  }
                ),
              ),

              SizedBox(height: 30 * scale,),

              // SIGNUP BUTTON

              SizedBox(
                width: size.width * 0.75,
                height: 70 * scale,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(97, 92, 233, 1.0),
                        Color.fromRGBO(55, 52, 131, 1.0),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(15),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: () {

                    },
                    child: Text(
                      'Crear cuenta',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20 * scale,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
