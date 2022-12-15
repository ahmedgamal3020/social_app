import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/conponents/conponents.dart';
import 'package:social_app/conponents/constant.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';

class EditProfileScreen extends StatelessWidget {
   const EditProfileScreen({super.key});


   @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit =AppCubit.get(context);
        var profileCaver =AppCubit.get(context).caverProfile;
        var profileImage =AppCubit.get(context).imageProfile;

        return Scaffold(
          appBar:defaultAppBar(
            title:const  Text('Edit Profile'),
            actions: [
              defaultTextButton(
                  onPressed:(){
                    if(profileImage!=null && cubit.userModel!.image != profileImage){
                      cubit.uploadProfileImage(
                          name:nameControllers!.text,
                          phone: phoneControllers!.text,
                          bio: bioControllers!.text
                      );
                    }
                    if(profileCaver!=null &&  profileCaver != cubit.userModel!.caver){
                      cubit.uploadProfileCaver(
                        name:nameControllers!.text,
                        phone: phoneControllers!.text,
                        bio: bioControllers!.text,
                      );
                    }
                    if(cubit.userModel!.name !=nameControllers!.text ||cubit.userModel!.phone!=phoneControllers!.text||cubit.userModel!.bio !=bioControllers!.text)
                    {
                      cubit.updateUserData(
                          name:nameControllers!.text,
                          phone: phoneControllers!.text,
                          bio: bioControllers!.text);
                    }

                  },
                  text:'UPDATE',

              ),
               const SizedBox(
                 width: 10
                 ,),
            ]
          ),
          body: ConditionalBuilder(
              condition:cubit.userModel!=null,
              builder: (context)=> SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [

                        SizedBox(
                          height: 205,
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Align(
                                alignment: Alignment.topCenter,
                                child: Stack(
                                  alignment: Alignment.bottomRight,
                                  children: [
                                    profileCaver==null?
                                    Container(
                                      width: double.infinity,
                                      height: 160.0,
                                      decoration: BoxDecoration(
                                          borderRadius:const  BorderRadius.only(
                                            bottomLeft:Radius.circular(10),
                                            bottomRight:Radius.circular(10),
                                          ),
                                          image: DecorationImage(
                                              image:NetworkImage('${cubit.userModel?.caver}'),
                                              fit: BoxFit.cover
                                          )
                                      ),
                                    )
                                        :
                                    Container(
                                      width: double.infinity,
                                      height: 160.0,
                                      decoration: BoxDecoration(
                                        borderRadius:const  BorderRadius.only(
                                          bottomLeft:Radius.circular(10),
                                          bottomRight:Radius.circular(10),
                                        ),
                                        image: DecorationImage(
                                            image:FileImage(profileCaver),
                                            fit: BoxFit.cover
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const  EdgeInsetsDirectional.only(
                                          end: 10
                                      ),
                                      child: CircleAvatar(
                                          radius:15,
                                          child: IconButton(
                                              onPressed: (){
                                                cubit.getCaver();
                                              },
                                              icon: const Icon(
                                                Icons.camera_alt_outlined,
                                                size: 15,
                                              ))
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  CircleAvatar(
                                    radius: 55,
                                    backgroundColor: Theme.of(context).backgroundColor,
                                    child:profileImage==null? CircleAvatar(
                                      radius: 50,
                                      backgroundImage: NetworkImage('${cubit.userModel?.image}',)
                                      ,
                                    )
                                        :
                                    CircleAvatar(
                                      radius: 50,
                                      backgroundImage: FileImage(profileImage)
                                      ,
                                    )
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 40,
                                    child: CircleAvatar(
                                        radius:15,
                                        child: IconButton(
                                            onPressed: (){
                                              cubit.getImage();
                                            },
                                            icon: const Icon(
                                              Icons.camera_alt_outlined,
                                              size: 15,
                                            ))
                                    ),
                                  ),
                                ],
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: SizedBox(
                                  width: 50,
                                  height: 30,
                                  child: defaultTextButton(
                                      onPressed:(){
                                        cubit.canChange();
                                      },
                                      text:'EDIT',
                                      fontSize: 10

                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10
                          ),
                          child: Column(
                            children: [

                              Container(
                                child: defaultTextFromFiled(
                                    enabled: cubit.toggle,
                                    controller: nameControllers,
                                    validator: (String?value)
                                    {
                                      if(value!.isEmpty){
                                        return 'Name Must Be Not Empty';
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.name,
                                    prefixIcon:const Icon(Icons.person),
                                    label: 'Name'
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                child: defaultTextFromFiled(
                                    enabled: cubit.toggle,
                                    controller: phoneControllers,
                                    validator: (String?value)
                                    {
                                      if(value!.isEmpty){
                                        return 'Phone Must Be Not Empty';
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.phone,
                                    prefixIcon:const Icon(Icons.call),
                                    label: 'Phone'
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                child: defaultTextFromFiled(
                                    enabled: cubit.toggle,
                                    controller: bioControllers,
                                    validator: (String?value)
                                    {
                                      if(value!.isEmpty){
                                        return 'Bio Must Be Not Empty';
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.name,
                                    prefixIcon:const Icon(Icons.edit),
                                    label: 'Bio'
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              fallback: (context)=>const Center(child: CircularProgressIndicator(),)
          )
        );
      },
    );
  }
}
