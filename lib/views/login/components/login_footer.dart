import 'package:eventify/views/register/register_page.dart';
import 'package:flutter/material.dart';

class LoginFooter extends StatefulWidget{
  final double scale;
  final double width;

  const LoginFooter({
    super.key, 
    required this.scale, 
    required this.width
  });
  
  @override
  State<StatefulWidget> createState() => _LoginFooter();
}

class _LoginFooter extends State<LoginFooter> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32 * widget.scale),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          SizedBox(
            width: widget.width * 0.75,
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
              fontSize: widget.scale * 15
            ),
          ),

          TextButton(
            onPressed: (){
              setState(() {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => RegisterPage())
                );
              });
            }, 
            child: Text(
              'Regístrate',
              style: TextStyle(
                color: Color.fromRGBO(252, 149, 54, 1.0),
                fontSize: 18 * widget.scale,
                fontWeight: FontWeight.w900
              ),
            )
          )
        ],
      ),
    );
  }

}