import 'package:flutter/material.dart';

class RegisterHeader extends StatefulWidget{
  final double scale;

  const RegisterHeader({super.key, required this.scale});
  
  @override
  State<StatefulWidget> createState() => _RegisterHeader();
}

class _RegisterHeader extends State<RegisterHeader> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: (widget.scale * 32)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              setState(() {
                Navigator.pop(context);
              });
            }, 
            icon: Icon(Icons.arrow_back),
            color: Color.fromRGBO(97, 92, 233, 1.0),
            iconSize: (widget.scale * 35),
          ),
          Text(
            'Crea tu cuenta',
            style: TextStyle(
              fontSize: (widget.scale * 30),
              fontWeight: FontWeight.w900,
              color: Color.fromRGBO(97, 92, 233, 1.0)
            ),
          )
        ],
      ),
    );
  }

}