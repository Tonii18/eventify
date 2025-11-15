import 'package:eventify/views/verification/components/verification_header.dart';
import 'package:eventify/views/widgets/elevated_button.dart';
import 'package:flutter/material.dart';

class VerificationPage extends StatefulWidget{
  const VerificationPage({super.key});
  
  @override
  State<StatefulWidget> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
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

            children: [
              VerificationHeader(scale: scale),
              
              CustomeElevatedButton(
                width: (size.width * 0.75), 
                height: (70 * scale), 
                scale: scale, 
                borderRadius: 15, 
                text: 'Verifical Email', 
                textColor: Colors.white,
                colorGradient: [
                  Color.fromRGBO(97, 92, 233, 1.0),
                  Color.fromRGBO(55, 52, 131, 1.0)
                ],
                fontSize: (20 * scale), 
                fontWeight: FontWeight.w900
              ),
            ],
          ),
        ),
      ),
    );
  }

}