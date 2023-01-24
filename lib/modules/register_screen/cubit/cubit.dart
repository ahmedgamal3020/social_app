import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/social_user_model.dart';
import 'package:social_app/modules/register_screen/cubit/states.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates>
{
  SocialRegisterCubit():super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context)=>BlocProvider.of(context);


  bool isPassword=true;

  void showPassword(){
    isPassword  =! isPassword;
    emit(SocialShowRegisterPasswordState());
  }

  //use to take user data
  // SocialUserModel? registerModel;
  void userRegister(
      {
        @required String? email,
        @required String? password,
        @required String? name,
        @required String? phone,

      }){
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email!,
        password: password!
    ).then((value)
    {
      createUser(
          email: email,
          name: name,
          phone: phone,
          uId: value.user!.uid
      );
      print(value.user!.email);
      print(value.user!.uid);
    }).catchError((error){
      emit(SocialRegisterErrorState(error));
      print('Error = ${error.toString()} ');
    });

  }


  void createUser({
    @required String? email,
    @required String? name,
    @required String? phone, 
    @required String? uId,
}){
    AppUserModel model =AppUserModel(

      email: email,
      name: name!,
      phone: phone,
      uId: uId!,
      isEmailVerified: false,
      image: 'https://i.stack.imgur.com/l60Hf.png',
      caver: 'https://www.shutterstock.com/image-vector/vector-girl-caver-cave-stalactites-260nw-658576036.jpg',
      bio: 'Write Your Boi... ',
    );
    FirebaseFirestore.instance.
    collection('users').
    doc(uId).
    set(model.toMap()).
    then((value)
    {
      print(model.name);
      print(model.email);

      emit(SocialCreateUserSuccessState(model.uId));
    }).catchError((error)
    {
      print('Error = ${error.toString()}');
      emit(SocialCreateUserErrorState(error));
    });
  }

}