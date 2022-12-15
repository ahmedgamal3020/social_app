import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social_app/style/colors.dart';

ThemeData defaultTheme = ThemeData(
    primarySwatch: defaultColor,
    appBarTheme:const  AppBarTheme(
      iconTheme: IconThemeData(
        color: Colors.black
      ),
       systemOverlayStyle: SystemUiOverlayStyle(
         statusBarColor: Colors.white,
         statusBarIconBrightness: Brightness.dark
       ),
      color: Colors.white,
      titleTextStyle: TextStyle(
       color: Colors.black,
       fontSize: 15,
       fontWeight: FontWeight.bold
      ),
      actionsIconTheme: IconThemeData(
       color: Colors.black
      ),
       elevation: 0
     ),
    textTheme:const TextTheme(
      subtitle1: TextStyle(
        height: 1.2,
        fontSize: 14,
        overflow: TextOverflow.ellipsis,

      ),
      caption: TextStyle(
        fontSize: 10
      ),
      bodyText1: TextStyle(
        fontSize: 20
      )
    ),
    bottomNavigationBarTheme:const  BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
    unselectedLabelStyle: TextStyle(
      color: Colors.grey
    ),
    elevation: 20,
    selectedItemColor: Colors.blue,
    unselectedItemColor: Colors.grey,
    showUnselectedLabels: true,
    selectedIconTheme: IconThemeData(
      color: Colors.blue,

    )
  )
 );

