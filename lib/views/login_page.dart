import 'package:eventify/views/register_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scale = size.width / 400;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Center(
        // This wrap the content so that it can be moved without being out of the screen
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 20 * scale), // TODO
          // This is all the content which is wrapped inside the 'SingleChildScrollView'
          child: Column(
            // Align all the items to the center
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,

            // Array which contains every screen´s component
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32 * scale),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bienvenido a',
                      style: TextStyle(
                        fontSize: 35 * scale,
                        fontWeight: FontWeight.w900,
                        color: Color.fromRGBO(97, 92, 233, 1.0),
                      ),
                    ),

                    Text(
                      'Eventify',
                      style: TextStyle(
                        fontSize: 35 * scale,
                        fontWeight: FontWeight.w900,
                        color: Color.fromRGBO(252, 149, 54, 1.0)
                      ),
                    )
                  ],
                ),
              ),

              SizedBox(
                height: 40 * scale,
              ),

              Image.asset(
                'lib/assets/images/app_icon.png',
                width: 150 * scale,
                height: 150 * scale,
              ),

              SizedBox(
                height: 30 * scale,
              ),

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
                        color: Color.fromRGBO(180, 180, 180, 1.0),
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 16 * scale),

              SizedBox(
                width: size.width * 0.75,
                child: TextFormField(
                  obscureText: true,
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
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 30 * scale,
              ),

              SizedBox(
                width:size.width * 0.75,
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
                      //TODO: Here the action when the button is pressed
                    },
                    child: Text(
                      'Iniciar sesion',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20 * scale,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 30 * scale,
              ),

              SizedBox(
                width: size.width * 0.75,
                child: Divider(
                  height: 20,
                  thickness: 1,
                  color: Color.fromRGBO(63, 61, 86, 0.5),
                ),
              ),

              Text(
                '¿No tienes cuenta?',
                style: TextStyle(
                  color: Color.fromRGBO(97, 92, 233, 1.0),
                  fontSize: 15 * scale,
                ),
              ),

              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterPage()) 
                  );
                },
                child: Text(
                  'Regístrate',
                  style: TextStyle(
                    color: Color.fromRGBO(252, 149, 54, 1.0),
                    fontSize: 18 * scale,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
