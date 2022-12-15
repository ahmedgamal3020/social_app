import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/conponents/constant.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/home_screen.dart';
import 'package:social_app/modules/login_screen/login_screen.dart';
import 'package:social_app/network/local/cache_helper.dart';
import 'package:social_app/style/theme.dart';
import 'firebase_options.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
   await CacheHelper.init();
   Widget widget;
    uIds =CacheHelper.getData(key: 'uId');
   if(uIds !=null){
     widget= HomeScreen();
   }
   else{
     widget= LoginScreen();
   }
  runApp( MyApp(
    startWidget:widget ,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  const MyApp({super.key, required this.startWidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context)=>AppCubit()..getPosts()..getUserData())
        ], child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: defaultTheme,
    home:startWidget,
    )
    );

  }
}


