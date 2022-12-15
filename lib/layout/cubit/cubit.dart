import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/conponents/constant.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/models/social_user_model.dart';
import 'package:social_app/modules/chats/chats_screen.dart';
import 'package:social_app/modules/feeds/feeds_screen.dart';
import 'package:social_app/modules/new_post/new_post.dart';
import 'package:social_app/modules/settings/settings_screen.dart';
import 'package:social_app/modules/users/users_screen.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit():super(AppInitialState());

  static AppCubit get(context)=>BlocProvider.of(context);

  //get all user data from data base to home screen
   AppUserModel? userModel;
   getUserData(){
    emit(AppGetUserLoadingState());

    FirebaseFirestore.instance
        .collection('users')
        .doc(uIds)
        .get()
        .then((value) {
          userModel=AppUserModel.fromJson(value.data()!);
          nameControllers?.text=userModel!.name!;
          bioControllers?.text=userModel!.bio!;
          phoneControllers?.text=userModel!.phone!;
          emit(AppGetUserSuccessState());
    }).catchError((error){
      emit(AppGetUserErrorState(error));
    });
  }


  //toggle between the screens
   int currentIndex=0;
   List<Widget> screens=   [
     FeedsScreen(),
     ChatsScreen(),
     NewPostScreen(),
     UsersScreen(),
     SettingsScreen(),

   ];

  //toggle between the app bar screens
  List<String> appBarNameScreens=const [
    'Home',
    'Chats',
    'Post',
    'Users',
    'Settings',


  ];

  //change the bottom nav bar
   void changeBottomNav(int index){
     if(index==1) {
       getUsers();
       print('data');

     }

     if(index==2) {
       emit(AppNewPostState());
     }

       currentIndex=index;
       emit(AppBottomNavState());


   }

   // use this method to change button on edit screen to you can edit you name or phone or bio
   bool toggle=false;
void canChange(){
  toggle=!toggle;
  emit(AppCanChangeState());
}

//get profile image from user phone
 File? imageProfile;
 var picker =ImagePicker();
 Future<void> getImage()async
 {
   final pickerFile= await picker.pickImage(source: ImageSource.gallery);
   if(pickerFile!=null){
     imageProfile = File(pickerFile.path);
     emit(AppGetImageSuccessState());

   }
   }

  //get profile caver from user phone
  File? caverProfile;
  var pickerCaver =ImagePicker();
  Future<void> getCaver()async
  {
    var pickerFile= await picker.pickImage(source: ImageSource.gallery);
    if(pickerFile!=null){
      caverProfile = File(pickerFile.path);
      emit(AppGetCaverSuccessState());

    }
  }

  // upload user image profile to data base
Reference get firebaseStorage =>FirebaseStorage.instance.ref();
  void uploadProfileImage({
    @required name,
    @required phone,
    @required bio,
  }){
    firebaseStorage.child('users').child(Uri.file(imageProfile!.path).pathSegments.last)
        .putFile(imageProfile!).then((value){
          value.ref.getDownloadURL().then((value){

            updateUserData(
                name: name,
                phone: phone,
                bio: bio,
                image: value
            );
            emit(AppUploadProfileImageSuccessState());
                 print('image =$value');
          })
              .catchError((error){
                emit(AppUploadProfileImageErrorState());
                print('Error = $error');
          });
    })
        .catchError((error){
      emit(AppUploadProfileImageErrorState());
      print('Error 2  = $error');


    });
  }

  // upload user caver profile to storage
  void uploadProfileCaver({
    @required name,
    @required phone,
    @required bio,
}){
    FirebaseStorage.instance.ref().child('users').child(Uri.file(caverProfile!.path).pathSegments.last)
        .putFile(caverProfile!).then((value){
      value.ref.getDownloadURL().then((value){
        updateUserData(
          name: name,
          phone: phone,
          bio: bio,
          caver: value
        );
        emit(AppUploadProfileCaverSuccessState());
        print('image =$value');
      }).catchError((error){
            emit(AppUploadProfileCaverErrorState());
        print('Error = $error');
      });
    }).catchError((error){
      emit(AppUploadProfileCaverErrorState());
      print('Error 2  = $error');
    });
  }



// update dateBase to the new data
  void updateUserData({
    @required name,
    @required phone,
    @required bio,
    String? image,
    String? caver,
  }){
    emit(AppUpdateUserDataLoadingState());
    AppUserModel? model=AppUserModel(
        name:name,
        bio:bio ,
        phone:phone ,
        image: image??userModel!.image,
        caver: caver??userModel!.caver,
        isEmailVerified: false,
        uId: userModel!.uId,
        email:userModel!.email
    );
    FirebaseFirestore
        .instance
        .collection('users')
        .doc(userModel!.uId)
        .update(model.toMap())
        .then((value){
          getUserData();

    })
        .catchError((error){
          print("Error= $error");
          emit(AppUpdateUserDataErrorState());
    });
  }

  //get post image from user phone
  File? postImage;
  var pickerPostImage =ImagePicker();
  Future<void> getPostImage()async
  {
    var pickerFile= await pickerPostImage.pickImage(source: ImageSource.gallery);
    if(pickerFile!=null){
      postImage = File(pickerFile.path);
      emit(AppGetPostImageSuccessState());
    }
  }

  void removePostImage(){
    postImage =null;
    emit(AppRemovePostImageSuccessState());
  }

  // upload new post to storage with image post
  Future<void>? uploadNewPostImage({
  @required String?name,
  @required String?text,
  @required String?image,
  @required String?dateTime,
}){
    emit(AppCreatePostLoadingState());
    FirebaseStorage.instance
        .ref()
        .child('posts')
        .child(Uri.file(postImage!.path)
        .pathSegments.last)
        .putFile(postImage!).then((value){
     value.ref.getDownloadURL().then((value){
       createNewPost(
           text: text,
           dateTime: dateTime,
         postImage: value
       );

     }).catchError((error){
       emit(AppCreatePostErrorState());
       print('Error = $error');
     });
    }).catchError((error){
      emit(AppCreatePostErrorState());
      print('Error 2  = $error');
    });

  }

  //set new post to dataBase without image
  Future<void>? createNewPost({
    @required String?text,
    @required String?dateTime,
    String? postImage,
  }){
    emit(AppCreatePostLoadingState());
    PostModel? model =PostModel(
      name: userModel!.name,
      image:userModel!.image,
      uId: userModel!.uId,
      dateTime: dateTime,
      text: text,
      postImage: postImage
    );
    FirebaseFirestore
        .instance
        .collection('posts')
        .add(model.toMap())
        .then((value){
          emit(AppCreatePostSuccessState());
    })
        .catchError((error){
      print("Error= $error");
      emit(AppCreatePostErrorState());
    });
  }

  // get post from dataBase {name, title, dateTime, comments,likes}
  late List<PostModel>posts=[];
  late List<String>postId=[];
  late List<int>comments=[];
  late List<int>likes=[];
  Stream<Object?>? getPosts(){
    emit(AppGetPostsLoadingState());
    FirebaseFirestore
        .instance
        .collection('posts')
        .orderBy("dateTime",descending: true)
        .snapshots()
        .listen((event)async {
          posts=[];
      for (var i in event.docs) {
       await i.reference.collection('likes')
            .get().then((value){
          likes.add(value.docs.length);
          postId.add(i.id);
          posts.add(PostModel.fromJson(i.data()));
        }).catchError((error){
          print('Error 2 = ${error.toString()}');
          emit(AppGetPostsErrorState(error));

        });
       await i.reference.collection('comments')
            .get().then((value){
          comments.add(value.docs.length);
        }).catchError((error){});
      }

          emit(AppGetPostsSuccessState());
    });

   }


List<AppUserModel> users=[];
    getUsers(){

     if(users.isEmpty) {
       FirebaseFirestore.instance.collection('users').get().then((value){
       for(var i in value.docs){
          if(i.data()['uId']!=userModel!.uId) {
           users.add(AppUserModel.fromJson(i.data()));
          }

       }
       print('getUsrts');
       emit(AppGetAllUsersSuccessState());
     }).catchError((error){
       print('Error = ${error.toString()}');
       emit(AppGetAllUsersErrorState(error));
     });
     }
   }


  void  setPostLike(
      @required String postId){
    FirebaseFirestore
        .instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({
      'like':true
    }).then((value){

    }
      ).catchError((error){
      emit(AppSetLikePostErrorState(error));

    });
  }

  void setPostComment(
      @required String postId
      ){
    FirebaseFirestore
        .instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(userModel!.uId)
        .set({
      'comment':true
        })
        .then((value){
    })
        .catchError((error){
      print("Error = ${error.toString()}");

      emit(AppSetCommentPostErrorState(error.toString()));

    });

  }

  void sendMessage({
  required String receiverId,
  required String dateTime,
  required String text,
}){
      MessageModel model = MessageModel(
        text: text,
        dateTime: dateTime,
        receiverId: receiverId,
        senderId: userModel!.uId
      );
      FirebaseFirestore.instance
      .collection('users')
      .doc(userModel!.uId)
      .collection('chats')
      .doc(receiverId)
      .collection('messages')
      .add(model.toMap()).then((value){
        emit(AppSendMessageSuccessState());
      }).catchError((error){
        emit(AppSendMessageErrorState());
      });
      FirebaseFirestore.instance
          .collection('users')
          .doc(receiverId)
          .collection('chats')
          .doc(userModel!.uId)
          .collection('messages')
          .add(model.toMap()).then((value){
        emit(AppSendMessageSuccessState());
      }).catchError((error){
        emit(AppSendMessageErrorState());
      });
  }
  List<MessageModel>messages=[];
   getMessages({
    @required String? receiverId,

  }){
     FirebaseFirestore.instance
         .collection('users')
         .doc(uIds)
         .collection('chats')
         .doc(receiverId)
         .collection('messages')
         .orderBy('dateTime',descending: true)
         .snapshots()
         .listen((event) {
       messages = [];
       event.docs.forEach((element) {
             messages.add(MessageModel.fromJson(element.data()));
           });
       emit(AppGetMessageSuccessState());
     });

  }


}


