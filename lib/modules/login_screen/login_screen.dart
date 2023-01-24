
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/conponents/conponents.dart';
import 'package:social_app/core/conponents/constant.dart';
import 'package:social_app/layout/home_screen.dart';
import 'package:social_app/modules/login_screen/cubit/cubit.dart';
import 'package:social_app/modules/login_screen/cubit/states.dart';
import 'package:social_app/modules/register_screen/register_screen.dart';
import 'package:social_app/network/local/cache_helper.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController =TextEditingController();

  TextEditingController passwordController =TextEditingController();

  var formKey =GlobalKey<FormState>();

  @override
  Widget build(BuildContext context)
  {
    return BlocProvider(
        create: (BuildContext context)=>SocialLoginCubit(),
        child: BlocConsumer<SocialLoginCubit,SocialLoginStates>(
            listener: (context,state)async {
              if(state is SocialLoginSuccessState){
               await CacheHelper.saveData(
                    key: 'uId',
                    value:state.uId
                )!.then((value)
               {
                 uIds=state.uId;
               });
               await navigateAndFinish(context, HomeScreen());
              }
              if(state is SocialLoginErrorState)
              {
                defaultToast(
                    state: ToastState.error,
                    text: state.error.toString());
              }
            },
            builder: (context,state){
              var cubit =SocialLoginCubit.get(context);
              return Form(
                key: formKey,
                child: Scaffold(
                  body: Center(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                                'LOGIN',
                                style:TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold
                                )
                            ),
                            defaultSizedBox(),
                            const Text(
                              'login new to browse our hot offers',
                              style: TextStyle(
                                  fontSize: 19
                              ),
                            ),
                            defaultSizedBox(),
                            Container(
                              child: defaultTextFromFiled(
                                  controller: emailController,
                                  validator: (String? value)
                                  {
                                    if(value!.isEmpty)
                                    {
                                      return 'Enter You Email';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  prefixIcon:const Icon(Icons.email_outlined),
                                  label: 'Email Address',
                                  border:const OutlineInputBorder()
                              ),
                            ),
                            defaultSizedBox(),
                            Container(
                              child: defaultTextFromFiled(
                                  controller: passwordController,
                                  obscureText: cubit.isPassword,
                                  validator: (String? value)
                                  {
                                    if(value!.isEmpty)
                                    {
                                      return 'must to be not empty';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.visiblePassword,
                                  prefixIcon:const Icon(Icons.lock_outline),
                                  label: 'Password',
                                  suffixIcon:IconButton(
                                      onPressed:()
                                      {
                                        cubit.showPassword();
                                      },
                                      icon:Icon(cubit.isPassword?Icons.remove_red_eye_outlined
                                          :Icons.remove_moderator
                                      )
                                  ),
                                  border:const OutlineInputBorder()
                              ),
                            ),
                            defaultSizedBox(),
                            ConditionalBuilder(
                              condition: state is!SocialLoginLoadingState,
                              fallback: (context)=>const Center(child: CircularProgressIndicator()),
                              builder:(context)=> defaultButton(
                                onPressed:()
                                {
                                  if( formKey.currentState!.validate()) {
                                    cubit.userLogin(
                                        email: emailController.text,
                                        password: passwordController.text
                                    );

                                  }
                                },
                                text:'LOGIN',
                                width: double.infinity,
                              ),
                            ),
                            defaultSizedBox(),
                            defaultTextButton(
                                onPressed:()
                                {
                                   navigateTo(context, RegisterScreen());
                                },
                                text:'Register'
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }
        )
    );
  }
}

Widget defaultSizedBox()=> const SizedBox
  (
  height: 15,
);