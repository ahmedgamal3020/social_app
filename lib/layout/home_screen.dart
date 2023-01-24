
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/conponents/conponents.dart';
import 'package:social_app/core/conponents/constant.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build( context) {
    return BlocProvider(
        create: (context)=> AppCubit()..getUserData()..getPosts(),
        child: BlocBuilder<AppCubit,AppStates>(
            builder:(context,state){
              var cubit =AppCubit.get(context);
              return Scaffold(
                  appBar: defaultAppBar(
                    title: Text(cubit.appBarNameScreens[cubit.currentIndex]),
                    actions: [
                      defaultTextButton(
                          onPressed:(){
                            logout(context);
                          },
                          text:'LogOut',
                      )
                    ],
                  ),
                  body: cubit.screens[cubit.currentIndex],
                  bottomNavigationBar: BottomNavigationBar(
                    items:const[
                        BottomNavigationBarItem(
                            icon: Icon(Icons.feed_outlined),
                            label:'Feeds'
                        ),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.chat_bubble_outline),
                            label:'Chats'
                        ),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.post_add),
                            label:'Post'
                        ),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.person),
                            label:'Users'
                        ),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.settings),
                            label:'Settings'
                        ),
                      ],
                    currentIndex: cubit.currentIndex,
                    onTap:(index){
                      cubit.changeBottomNav(index);
                    } ,


                  ),
                );

            }

        ),
      );
  }
}
