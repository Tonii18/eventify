import 'package:eventify/config/theme.dart';
import 'package:eventify/services/auth_service.dart';
import 'package:eventify/views/login/login_page.dart';
import 'package:flutter/material.dart';

class HomeHeader extends StatefulWidget{
  final double scale;
  final double height;
  final double width;

  const HomeHeader({super.key, required this.scale, required this.height, required this.width});
  
  @override
  State<StatefulWidget> createState() => _HomeHeader();
}

class _HomeHeader extends State<HomeHeader> {
  @override
  Widget build(BuildContext context) {

    return Container(

      width: widget.width * 0.80,
      height: widget.height * 0.20,
      decoration: BoxDecoration(
        color: AppColors.white,
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
                  'Bienvenido',
                  style: TextStyle(
                    fontSize: 25 * widget.scale,
                    fontWeight: FontWeight.w900,
                    color: AppColors.darkBlue,
                  ),
                ),

                Text(
                  '¿Qué toca esta semana?\nNo te pierdas nada',
                  style: TextStyle(
                    fontSize: 15 * widget.scale,
                    fontWeight: FontWeight.w100,
                    color: AppColors.darkBlue,
                  ),
                ),
              ],
            ),

            IconButton(
              onPressed: () {
                AuthService auth = AuthService();
                auth.logout();
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
              },
              icon: Icon(Icons.logout_rounded),
              color: AppColors.darkBlue,
              iconSize: widget.scale * 40,
            ),
          ],
        ),
      ),

    );
  }

}