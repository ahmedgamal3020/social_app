
abstract class SocialRegisterStates {}

class SocialRegisterInitialState extends SocialRegisterStates {}

class SocialShowRegisterPasswordState extends SocialRegisterStates{}

class SocialRegisterLoadingState extends SocialRegisterStates {}

class SocialRegisterSuccessState extends SocialRegisterStates {}

class SocialRegisterErrorState extends SocialRegisterStates {

  final dynamic error;
  SocialRegisterErrorState(this.error);
}
class SocialCreateUserSuccessState extends SocialRegisterStates {
  final dynamic uId;

  SocialCreateUserSuccessState(this.uId);
}

class SocialCreateUserErrorState extends SocialRegisterStates {

  final dynamic error;
  SocialCreateUserErrorState(this.error);
}
