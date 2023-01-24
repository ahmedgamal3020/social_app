import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/conponents/conponents.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/modules/screens/edit_profile/edit_profile_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit,AppStates>(
        listener:(context,state){},
        builder:(context,state){
          var cubit =AppCubit.get(context);
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                //Caver Image And Profile Picture
                SizedBox(
                  height: 205,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          width: double.infinity,
                          height: 160.0,
                          decoration: BoxDecoration(
                            borderRadius:const  BorderRadius.only(
                                bottomLeft:Radius.circular(10),
                                bottomRight:Radius.circular(10),
                            ),
                            image:DecorationImage(
                                image: NetworkImage('${cubit.userModel!.caver}',
                                ),
                                fit: BoxFit.cover
                            ),
                          ),
                        ),

                      ),
                      CircleAvatar(
                        radius: 55,
                        backgroundColor: Theme.of(context).backgroundColor,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage('${cubit.userModel!.image}',),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    //Name
                    Text('${cubit.userModel!.name}',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    //bio
                    Text('${cubit.userModel!.bio}',
                      style: Theme.of(context).textTheme.caption,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    //how many Posts and followers and following
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            child: Column(
                              children: [
                                Text('Post',
                                  style:Theme.of(context).textTheme.subtitle1 ,),
                                Text('30',
                                  style:Theme.of(context).textTheme.caption ,),
                              ],
                            ),
                            onTap: (){},
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            child: Column(
                              children: [
                                Text('Photos',
                                  style:Theme.of(context).textTheme.subtitle1 ,),
                                Text('13',
                                  style:Theme.of(context).textTheme.caption ,),
                              ],
                            ),
                            onTap: (){},
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            child: Column(
                              children: [
                                Text('Followers',
                                  style:Theme.of(context).textTheme.subtitle1 ,),
                                Text('150k',
                                  style:Theme.of(context).textTheme.caption ,),
                              ],
                            ),
                            onTap: (){},
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            child: Column(
                              children: [
                                Text('Following',
                                  style:Theme.of(context).textTheme.subtitle1 ,),
                                Text('199',
                                  style:Theme.of(context).textTheme.caption ,),
                              ],
                            ),
                            onTap: (){},
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    //Button Edit Profile
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                              onPressed:(){} ,
                              child:const  Text('Add Photo')),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        OutlinedButton(
                            onPressed:(){
                              navigateTo(context, EditProfileScreen());
                            } ,
                            child:const Icon(Icons.edit)),
                      ],
                    )



                  ],
                )

              ],
            ),
          );
    }
    );
  }
}
