import 'package:flutter/material.dart';

class UserManagmentHeader extends StatefulWidget {
  final double scale;

  const UserManagmentHeader({super.key, required this.scale});

  @override
  State<StatefulWidget> createState() => _UserManagmentHeader();
}

class _UserManagmentHeader extends State<UserManagmentHeader> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: (widget.scale * 32)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back),
              color: Color.fromRGBO(63, 61, 86, 1.0),
              iconSize: (widget.scale * 35),
            ),
            Flexible(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  'Gestionar usuarios',
                  style: TextStyle(
                    fontSize: (widget.scale * 30),
                    fontWeight: FontWeight.w900,
                    color: Color.fromRGBO(63, 61, 86, 1.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
