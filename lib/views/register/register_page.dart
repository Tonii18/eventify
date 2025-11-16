import 'package:eventify/providers/auth_provider.dart';
import 'package:eventify/views/register/components/register_header.dart';
import 'package:eventify/views/verification/verification_page.dart';
import 'package:eventify/views/widgets/back_header.dart';
import 'package:eventify/views/widgets/elevated_button.dart';
import 'package:eventify/views/widgets/form_field.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? _defaultValue;
  
  final List<String> list = ['Usuario', 'Organizador'];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  String selectedRol = '';

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
              BackHeader(scale: scale, title: 'Crea tu cuenta', color: Color.fromRGBO(97, 92, 233, 1.0),),

              SizedBox(height: 16 * scale),

              // IMAGE
              Image.asset(
                'lib/assets/images/signup.png',
                width: 150 * scale,
                height: 150 * scale,
              ),

              SizedBox(height: 16 * scale),

              // FORMS FIELDS
              CustomeFormField(
                width: size.width * 0.75,
                borderRadius: 15,
                label: 'Nombre de usuario',
                color: Color.fromRGBO(180, 180, 180, 1.0),
                isPassword: false,
                textController: nameController,
              ),

              SizedBox(height: 16 * scale),

              CustomeFormField(
                width: size.width * 0.75,
                borderRadius: 15,
                label: 'Correo electrónico',
                color: Color.fromRGBO(180, 180, 180, 1.0),
                isPassword: false,
                textController: emailController,
              ),

              SizedBox(height: 16 * scale),

              CustomeFormField(
                width: size.width * 0.75,
                borderRadius: 15,
                label: 'Contraseña',
                color: Color.fromRGBO(180, 180, 180, 1.0),
                isPassword: true,
                textController: passwordController,
              ),

              SizedBox(height: 16 * scale),

              CustomeFormField(
                width: size.width * 0.75,
                borderRadius: 15,
                label: 'Confirmar contraseña',
                color: Color.fromRGBO(180, 180, 180, 1.0),
                isPassword: true,
                textController: confirmPasswordController,
              ),

              SizedBox(height: 16 * scale),

              // SELECT FIELD
              SizedBox(
                width: size.width * 0.75,
                child: DropdownButtonFormField(
                  initialValue: _defaultValue,
                  decoration: InputDecoration(
                    labelText: 'Selecciona tu rol',
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
                    contentPadding: EdgeInsets.symmetric(vertical: 32 * scale),
                  ),
                  items: list
                      .map(
                        (option) => DropdownMenuItem(
                          value: option,
                          child: Text(option),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _defaultValue = value.toString();
                      selectedRol = _defaultValue.toString();
                    });
                  },
                ),
              ),

              SizedBox(height: 30 * scale),

              // SIGNUP BUTTON
              CustomeElevatedButton(
                width: (size.width * 0.75),
                height: (scale * 70),
                scale: scale,
                borderRadius: 15,
                text: 'Crear cuenta',
                textColor: Colors.white,
                fontSize: (scale * 20),
                fontWeight: FontWeight.w900,
                colorGradient: [
                  Color.fromRGBO(97, 92, 233, 1.0),
                  Color.fromRGBO(55, 52, 131, 1.0),
                ],
                onPressed: () {
                  setState(() {
                    registerUser();
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> registerUser() async {
    String name = nameController.text;
    String email = emailController.text;
    String password = passwordController.text;
    String confirmPass = confirmPasswordController.text;
    String role = '';

    if (password == confirmPass) {
      AuthProvider authProvider = AuthProvider();

      if (selectedRol == 'Administrador') {
        role = 'a';
      } else if (selectedRol == 'Usuario') {
        role = 'u';
      } else {
        role = 'o';
      }

      if (await authProvider.register(name, email, password, role)) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => VerificationPage()),
        );
      }
    }
  }
}
