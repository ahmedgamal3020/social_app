
import 'package:flutter/material.dart';
import 'package:social_app/core/conponents/conponents.dart';
import 'package:social_app/modules/login_screen/login_screen.dart';
import 'package:social_app/network/local/cache_helper.dart';

TextEditingController? nameControllers=TextEditingController();
TextEditingController? bioControllers=TextEditingController();
TextEditingController? phoneControllers=TextEditingController();
TextEditingController? postControllers=TextEditingController();


 String? uIds;


void logout(context){
  CacheHelper.removeData(key: 'uId').then((value) {
    navigateAndFinish(context,const LoginScreen());
  });
}