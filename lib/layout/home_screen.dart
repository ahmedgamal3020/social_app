
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/conponents/conponents.dart';
import 'package:social_app/conponents/constant.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/modules/new_post/new_post.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});
  @override
  Widget build( context) {
    return BlocProvider(
        create: (context)=> AppCubit()..getUserData()..getPosts(),
        child: BlocConsumer<AppCubit,AppStates>(
            listener:(context,state)async{
              if(state is AppNewPostState){
                await navigateTo(context, const NewPostScreen());
              }
            },
            builder:(context,state){
              var cubit =AppCubit.get(context);
              return StreamBuilder(

                builder:(context,snapshot)=> Scaffold(
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
                ),
              );
            }

        ),
      );
  }
}
