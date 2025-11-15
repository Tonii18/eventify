import 'package:flutter/material.dart';

class CustomeFormField extends StatefulWidget{

  final String label;
  final double width;
  final double borderRadius;
  final Color color;
  final TextEditingController? textController;
  final bool isPassword;

  const CustomeFormField({
    super.key, 
    required this.width, 
    required this.borderRadius, 
    required this.label, 
    required this.color,
    this.textController, 
    required this.isPassword
  });
  
  @override
  State<StatefulWidget> createState() => _CustomeFormField();
}

class _CustomeFormField extends State<CustomeFormField>{
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width:  widget.width,
      child: TextFormField(
        obscureText: widget.isPassword,
        decoration: InputDecoration(
          labelText: widget.label,
          labelStyle: TextStyle(
            color: widget.color,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: widget.color,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius)
          )
        ),
        controller: widget.textController,
      ),
    );
  }

}