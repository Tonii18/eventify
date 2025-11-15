import 'package:flutter/material.dart';

class AdminMenuHeader extends StatefulWidget {
  final double scale;
  final double width;
  final double height;

  const AdminMenuHeader({super.key, required this.scale, required this.width, required this.height});

  @override
  State<StatefulWidget> createState() => _AdminMenuHeaderState();
}

class _AdminMenuHeaderState extends State<AdminMenuHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(

      width: widget.width * 0.80,
      height: widget.height * 0.15,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),

      child: Padding(

        padding: EdgeInsets.symmetric(horizontal: widget.scale * 20),

        child: Row(

          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  'Dashboard',
                  style: TextStyle(
                    fontSize: 25 * widget.scale,
                    fontWeight: FontWeight.w900,
                    color: Color.fromRGBO(63, 61, 86, 1.0),
                  ),
                ),

                Text(
                  'Gestiona tu aplicacion \ndesde aquí',
                  style: TextStyle(
                    fontSize: 15 * widget.scale,
                    fontWeight: FontWeight.w100,
                    color: Color.fromRGBO(63, 61, 86, 1.0),
                  ),
                ),
              ],
            ),

            IconButton(
              onPressed: () {},
              icon: Icon(Icons.settings_outlined),
              color: Color.fromRGBO(63, 61, 86, 1.0),
              iconSize: widget.scale * 40,
            ),
          ],
        ),
      ),
    );
  }
}
