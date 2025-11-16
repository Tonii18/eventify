import 'package:flutter/material.dart';

class BackHeader extends StatefulWidget{
  final double scale;
  final String title;
  final Color color;

  const BackHeader({super.key, required this.scale, required this.title, required this.color});
  
  @override
  State<StatefulWidget> createState() => _BackHeader();
}

class _BackHeader extends State<BackHeader> {
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
            color: widget.color,
            iconSize: (widget.scale * 35),
          ),
          Text(
            widget.title,
            style: TextStyle(
              fontSize: (widget.scale * 30),
              fontWeight: FontWeight.w900,
              color: widget.color
            ),
          )
        ],
      ),
    );
  }

}