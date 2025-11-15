import 'package:flutter/material.dart';

class VerificationHeader extends StatelessWidget {
  final double scale;
  const VerificationHeader({super.key, required this.scale});
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32 * scale),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Verifica tu',
            style: TextStyle(
              fontSize: 35 * scale,
              fontWeight: FontWeight.w900,
              color: Color.fromRGBO(97, 92, 233, 1.0)
            ),
          ),

          Text(
            'Email',
            style: TextStyle(
              fontSize: 35 * scale,
              fontWeight: FontWeight.w900,
              color: Color.fromRGBO(252, 149, 54, 1.0)
            ),
          ),

          SizedBox(
            height: 120 * scale,
          ),

          Image.asset(
            'lib/assets/images/verify_email.png',
            width: 280 * scale,
            height: 340 * scale,
          )
        ],
      ),
    );
  }

}