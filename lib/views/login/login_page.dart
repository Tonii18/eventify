import 'package:eventify/providers/auth_provider.dart';
import 'package:eventify/views/admin/admin_menu.dart';
import 'package:eventify/views/login/components/login_footer.dart';
import 'package:eventify/views/login/components/login_header.dart';
import 'package:eventify/views/widgets/elevated_button.dart';
import 'package:eventify/views/widgets/form_field.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final scale = size.width / 400;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Center(
        // This wrap the content so that it can be moved without being out of the screen
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 20 * scale),
          // This is all the content which is wrapped inside the 'SingleChildScrollView'
          child: Column(
            // Align all the items to the center
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,

            // Array which contains every screen´s component
            children: [
              
              LoginHeader(scale: scale),

              SizedBox(
                height: 30 * scale,
              ),

              CustomeFormField(
                width: (size.width * 0.75), 
                borderRadius: 15, 
                label: 'Correo electrónico', 
                color: Color.fromRGBO(180, 180, 180, 1.0), 
                isPassword: false,
                textController: emailController,
              ),

              SizedBox(height: 16 * scale),

              CustomeFormField(
                width: (size.width * 0.75), 
                borderRadius: 15, 
                label: 'Contraseña', 
                color: Color.fromRGBO(180, 180, 180, 1.0),
                isPassword: true,
                textController: passwordController,
              ),

              SizedBox(
                height: 30 * scale,
              ),
              
              CustomeElevatedButton(
                width: (size.width * 0.75), 
                height: (70 * scale),
                scale: scale, 
                borderRadius: 15, 
                text: 'Iniciar sesion', 
                textColor: Colors.white, 
                fontSize: (20 * scale), 
                fontWeight: FontWeight.w900,
                colorGradient: [
                  Color.fromRGBO(97, 92, 233, 1.0),
                  Color.fromRGBO(55, 52, 131, 1.0)
                ],
                onPressed: (){
                  setState(() {
                    loginUser();
                  });
                },
              ),

              SizedBox(
                height: 30 * scale,
              ),

              LoginFooter(
                scale: scale, 
                width: size.width
              ),

            ],
          ),
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    String email = emailController.text;
    String password = passwordController.text;

    AuthProvider authProvider = AuthProvider();
    
    if(await authProvider.login(email, password)){
      if(authProvider.user?.role == 'a'){
        Navigator.push(context,MaterialPageRoute(builder: (context) => AdminMenu()));
      }else if(authProvider.user?.role == 'u'){
        if(authProvider.user?.emailVerifiedAt != null && authProvider.user?.actived == 1){
          // Redirect to user home
        }
      }
    }
  }

}
