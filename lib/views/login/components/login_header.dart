import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget{
  final double scale;
  const LoginHeader({super.key, required this.scale});
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32 * scale),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          
          Text(
            'Bienvenido a',
            style: TextStyle(
              fontSize: 35 * scale,
              fontWeight: FontWeight.w900,
              color: Color.fromRGBO(97, 92, 233, 1.0)
            ),
          ),

          Text(
            'Eventify',
            style: TextStyle(
              fontSize: 35 * scale,
              fontWeight: FontWeight.w900,
              color: Color.fromRGBO(252, 149, 54, 1.0)
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

        ],
      ),
    );
  }
}