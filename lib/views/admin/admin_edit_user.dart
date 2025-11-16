import 'package:eventify/views/widgets/back_header.dart';
import 'package:eventify/views/widgets/form_field.dart';
import 'package:flutter/material.dart';

class AdminEditUser extends StatefulWidget {
  const AdminEditUser({super.key});

  @override
  State<StatefulWidget> createState() => _AdminEditUserState();
}

class _AdminEditUserState extends State<AdminEditUser> {
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
              BackHeader(scale: scale, title: 'Editar usuario', color: Color.fromRGBO(63, 61, 86, 1.0)),
            ],
          ),
        ),
      ),
    );
  }
}
