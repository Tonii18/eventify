import 'package:flutter/material.dart';

class CustomeElevatedButton extends StatefulWidget {

  final double width;
  final double height;
  final double scale;
  final Color? color;
  final List<Color>? colorGradient;
  final double borderRadius;
  final String text;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final VoidCallback? onPressed;

  const CustomeElevatedButton({
    super.key,
    required this.width,
    required this.height,
    required this.scale,
    this.color,
    this.colorGradient,
    required this.borderRadius,
    required this.text,
    required this.textColor,
    required this.fontSize,
    required this.fontWeight,
    this.onPressed
  });
  
  @override
  State<StatefulWidget> createState() => _CustomeElevatedButton();
}

class _CustomeElevatedButton extends State<CustomeElevatedButton> {
  @override
  Widget build(BuildContext context) {

    bool hasGradient = (widget.colorGradient != null && widget.colorGradient!.isNotEmpty);
    
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: hasGradient ? LinearGradient(colors: widget.colorGradient!) : null,
          color: hasGradient ? null : widget.color ?? Colors.transparent,
          borderRadius: BorderRadius.circular(widget.borderRadius)
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(widget.borderRadius)
            ),
            padding: EdgeInsets.zero
          ),
          onPressed: widget.onPressed, 
          child: Text(
            widget.text,
            style: TextStyle(
              color: widget.textColor,
              fontSize: widget.fontSize,
              fontWeight: widget.fontWeight
            ),
          )
        ),
      ),
    );
  }

}