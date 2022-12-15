import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/conponents/conponents.dart';
import 'package:social_app/conponents/constant.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/home_screen.dart';
import 'package:social_app/modules/register_screen/cubit/cubit.dart';
import 'package:social_app/modules/register_screen/cubit/states.dart';
import 'package:social_app/network/local/cache_helper.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);


  var nameController =TextEditingController();
  var emailController =TextEditingController();
  var phoneController =TextEditingController();
  var passwordController =TextEditingController();
  var formKey =GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context)=>SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit,SocialRegisterStates>(
          listener:(context,state)async{
            if(state is SocialCreateUserSuccessState){
              await CacheHelper.saveData(key: 'uId',
                  value:state.uId
              )!.then((value) {
                uIds=state.uId;
                print('uid= ${state.uId}');
              });
               await AppCubit.get(context).getUserData();
               await AppCubit.get(context).getPosts();
               await AppCubit.get(context).getUsers();
               await navigateAndFinish(context, HomeScreen());
            }
          },
          builder:(context,state){

            return Form(
              key: formKey,
              child: Scaffold(
                body:Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        children:
                        [
                          const Text('Register',
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            child: defaultTextFromFiled(
                                controller: nameController,
                                border:const OutlineInputBorder(),
                                validator: (String?value)
                                {
                                  if(value!.isEmpty)
                                  {
                                    return'con not be empty';
                                  }
                                  return null;
                                },
                                keyboardType:TextInputType.name,
                                prefixIcon:const Icon(Icons.drive_file_rename_outline),
                                label:'NAME'),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            child: defaultTextFromFiled(
                                controller: emailController,
                                validator: (String?value)
                                {
                                  if(value!.isEmpty)
                                  {
                                    return'con not be empty';
                                  }
                                  return null;
                                },
                                keyboardType:TextInputType.emailAddress,
                                prefixIcon:const Icon(Icons.email_outlined),
                                label:'EMAIL ADDRESS',
                                border:const OutlineInputBorder()
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            child: defaultTextFromFiled(
                                controller: phoneController,
                                border:const OutlineInputBorder(),
                                validator: (String?value)
                                {
                                  if(value!.isEmpty)
                                  {
                                    return'con not be empty';
                                  }
                                  return null;
                                },
                                keyboardType:TextInputType.phone,
                                prefixIcon:const Icon(Icons.phone),
                                label:'PHONE'
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            child: defaultTextFromFiled(
                              controller: passwordController,
                              border:const OutlineInputBorder(),
                              validator: (String?value)
                              {
                                if(value!.isEmpty)
                                {
                                  return'con not be empty';
                                }
                                return null;
                              },
                              keyboardType:TextInputType.visiblePassword,
                              prefixIcon:const Icon(Icons.password),
                              label:'PASSWORD',
                              obscureText: SocialRegisterCubit.get(context).isPassword,
                              suffixIcon: IconButton(
                                  onPressed:()
                                  {
                                    SocialRegisterCubit.get(context).showPassword();
                                  },
                                  icon:Icon(SocialRegisterCubit.get(context).isPassword?Icons.remove_moderator
                                      :Icons.remove_red_eye_outlined

                                  )
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          ConditionalBuilder(
                            condition: state is!SocialRegisterLoadingState,
                            fallback: (context)=>const Center(child: CircularProgressIndicator()),
                            builder:(context)=> defaultButton(
                              onPressed:()
                              {
                                if( formKey.currentState!.validate()) {
                                  SocialRegisterCubit.get(context).userRegister(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      name: nameController.text,
                                      phone: phoneController.text
                                  );
                                }
                              },
                              text:'OK',
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
      ),
    );
  }
}