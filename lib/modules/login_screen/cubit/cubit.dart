import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/login_screen/cubit/states.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates>
{
  SocialLoginCubit():super(SocialLoginInitialState());

  static SocialLoginCubit get(context)=>BlocProvider.of<SocialLoginCubit>(context);

  //use to take user data

  bool isPassword=true;

  void showPassword(){
    isPassword=! isPassword;
    emit(SocialShowPassword());
  }


  void userLogin(
      {
        required String email,
        required String password
      }) {
    emit(SocialLoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
      password: password,
    ).then((value) {
      print(value.user!.email);
      print(value.user!.uid);
        emit(SocialLoginSuccessState(value.user!.uid));
      }).catchError((error){
        emit(SocialLoginErrorState(error));
        print('Error = ${error.toString()} ');
      });

    }
  }
