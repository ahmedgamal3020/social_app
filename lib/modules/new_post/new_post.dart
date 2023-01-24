import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/conponents/conponents.dart';
import 'package:social_app/core/conponents/constant.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/layout/home_screen.dart';
import 'package:social_app/style/colors.dart';


class NewPostScreen extends StatelessWidget {
  const NewPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
        listener: (context,state)async{
        },
        builder: (context,state){
          var cubit= AppCubit.get(context);
          return Scaffold(
            appBar:defaultAppBar(
                title:const  Text('Create Post'),
                leading:defaultIconButton(
                    onPressed:(){
                      Navigator.pop(context);
                    },
                    icon:const Icon(Icons.arrow_back_ios)
                ),
                actions: [
                  (
                      defaultTextButton(
                        onPressed: ()async{
                          var timeNow=DateTime.now().toLocal();
                           if(cubit.postImage!=null){
                          await cubit.uploadNewPostImage(
                                name:cubit.userModel!.name,
                                text: postControllers!.text,
                                image: cubit.userModel!.image,
                                dateTime: timeNow.toString()
                            );

                           }
                           else{
                           await cubit.createNewPost(
                                text:  postControllers!.text,
                                dateTime: timeNow.toString()
                            );
                          }
                          await navigateAndFinish(context, HomeScreen()).then((value){
                            postControllers?.text==null;
                            AppCubit().postImage==null;
                          });

                        },
                        text: 'Post',
                      )
                  )
                ]
            ),
            body: ConditionalBuilder(
              condition: state is! AppUpdateUserDataLoadingState,
              builder: (context)=> Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if(state is AppCreatePostLoadingState)
                      const LinearProgressIndicator(),
                    if(state is AppCreatePostLoadingState)
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        if(cubit.userModel?.image!=null)
                        CircleAvatar(
                            radius: 20.0,
                            backgroundImage:NetworkImage('${cubit.userModel?.image}' ,
                            )
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        if(cubit.userModel?.name!=null)
                        Expanded(
                          child:
                          Text('${cubit.userModel?.name}',
                            style:const  TextStyle(
                                height: 1.3
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    myDivider(),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            TextFormField(
                              controller: postControllers,
                              maxLines: null,
                              keyboardType: TextInputType.multiline,
                              decoration:const  InputDecoration(
                                border: InputBorder.none,
                                hintText: 'what is on your mind.....?',

                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            if(cubit.postImage!=null)
                              Card(
                                  margin: EdgeInsets.zero,
                                  elevation: 9.0,
                                  child: Stack(
                                    children: [

                                      Image(
                                        width: double.infinity,
                                        height: 200,
                                        image:FileImage(cubit.postImage!) ,
                                        fit: BoxFit.cover,

                                      ),
                                      Positioned(
                                        top: 1,
                                        right: 1,
                                        child:IconButton(
                                          icon:const  Icon(Icons.close,
                                              color: defaultColor),
                                          onPressed: (){
                                            cubit.removePostImage();
                                          },

                                        ),
                                      ),


                                    ],
                                  )
                              ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(
                              onPressed: (){
                                cubit.getPostImage();
                              },
                              child: Row(
                                children: const [
                                  Icon(Icons.image),
                                  Text( 'Add Photo'
                                )

                                ],
                              ),
                            ),
                          TextButton(
                            onPressed: (){},
                            child: defaultTextButton(
                                onPressed:(){
                                  FirebaseAuth.instance.currentUser?.sendEmailVerification().then((value){
                                    print("Value");
                                  }).catchError((error){
                                    print("Error=$error");
                                  });
                                },
                                text: '# tags'
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              fallback:(context)=>const Center(child: CircularProgressIndicator(),),
            ),
          );
        },

      );
  }
}
