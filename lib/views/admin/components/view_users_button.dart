import 'package:flutter/material.dart';

class ViewUsersButton extends StatefulWidget {
  final double width;
  final double height;
  final double scale;

  const ViewUsersButton({
    super.key,
    required this.width,
    required this.height,
    required this.scale,
  });

  @override
  State<StatefulWidget> createState() => _ViewUsersButtonState();
}

class _ViewUsersButtonState extends State<ViewUsersButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(

      width: widget.width * 0.80,
      height: widget.height * 0.08,

      child: TextButton(
        onPressed: () {
          
        },
        style: TextButton.styleFrom(
          backgroundColor: const Color.fromRGBO(97, 92, 233, 1.0),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          textStyle: TextStyle(
            fontSize: 20 * widget.scale,
            fontWeight: FontWeight.w900,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Ver usuarios'),
            Icon(Icons.arrow_forward_ios_rounded, size: 25 * widget.scale),
          ],
        ),
      ),
    );
  }
}
