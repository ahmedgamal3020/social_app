
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

abstract class SocialLoginStates {}

class SocialLoginInitialState extends SocialLoginStates {}

class SocialShowPassword extends SocialLoginStates{}

class SocialLoginLoadingState extends SocialLoginStates {}

class SocialLoginSuccessState extends SocialLoginStates {
  late final String uId;
  SocialLoginSuccessState(this.uId);
}

class SocialLoginErrorState extends SocialLoginStates {

  final FirebaseAuthException error;
  SocialLoginErrorState(this.error);
}