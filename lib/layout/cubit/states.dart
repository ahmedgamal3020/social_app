abstract class AppStates{}

class AppInitialState extends AppStates{}

//get user data
class AppGetUserLoadingState extends AppStates{}

class AppGetUserSuccessState extends AppStates{}

class AppGetUserErrorState extends AppStates{
  final dynamic error;

  AppGetUserErrorState(this.error);
}
//get all users
class AppGetAllUsersLoadingState extends AppStates{}

class AppGetAllUsersSuccessState extends AppStates{}

class AppGetAllUsersErrorState extends AppStates {
  final dynamic error;

  AppGetAllUsersErrorState(this.error);
}

class AppBottomNavState extends AppStates{}

class AppNewPostState extends AppStates{}

class AppCanChangeState extends AppStates{}

class AppGetImageSuccessState extends AppStates{}

class AppGetImageErrorState extends AppStates{}

class AppGetCaverSuccessState extends AppStates{}

class AppGetCaverErrorState extends AppStates{}

class AppUploadProfileImageSuccessState extends AppStates{}

class AppUploadProfileImageErrorState extends AppStates{}

class AppUploadProfileCaverSuccessState extends AppStates{}

class AppUploadProfileCaverErrorState extends AppStates{}

class AppUpdateUserDataLoadingState extends AppStates{}

class AppUpdateUserDataErrorState extends AppStates{}

//create post

class AppCreatePostLoadingState extends AppStates{}

class AppCreatePostSuccessState extends AppStates{}

class AppCreatePostErrorState extends AppStates{}

class AppGetPostImageSuccessState extends AppStates{}

class AppRemovePostImageSuccessState extends AppStates{}

// get post data

class AppGetPostsLoadingState extends AppStates{}

class AppGetPostsSuccessState extends AppStates{}

class AppGetPostsErrorState extends AppStates{
  final dynamic error;

  AppGetPostsErrorState(this.error);
}

// set Like post


class AppSetLikePostErrorState extends AppStates {
  final dynamic error;

  AppSetLikePostErrorState(this.error);
}

// set comments post

class AppSetCommentPostErrorState extends AppStates {
  final dynamic error;

  AppSetCommentPostErrorState(this.error);
}

//send Message
class AppSendMessageSuccessState extends AppStates{}
class AppSendMessageErrorState extends AppStates{}
class AppGetMessageSuccessState extends AppStates{}

class AppToggleKeyboardTypeState extends AppStates{}
