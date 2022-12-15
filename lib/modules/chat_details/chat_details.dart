import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/social_user_model.dart';
import 'package:social_app/style/colors.dart';

class ChatDetailsScreen extends StatelessWidget {
  final AppUserModel model;

  ChatDetailsScreen({
    super.key,
    required this.model
  });
  var globalKey =GlobalKey<FormState>();
  final listViewController =ScrollController();
  var messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        AppCubit.get(context).getMessages(receiverId: model.uId!);
        return BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Form(
              key: globalKey,
              child: Scaffold(
                appBar: AppBar(
              title: Row(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                          radius: 15.0,
                          foregroundImage:NetworkImage('${model.image}',
                          )
                      ),
                      const SizedBox(
                        width: 10,
                      ),

                      Text('${model.name}',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
                  ),
                ],
              ),
          ),
                body: ConditionalBuilder(
                  condition:AppCubit.get(context).messages.length>=0,
                  builder: (context){
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          reverse: true,
                          controller: listViewController,
                          itemBuilder: (context,index){
                              var message = AppCubit.get(context).messages[index].senderId;
                              if(AppCubit.get(context).userModel!.uId==message) {
                               return buildMyMessages(AppCubit.get(context).messages[index]);
                              }
                              return buildYourMessages(AppCubit.get(context).messages[index]);
                            },
                            separatorBuilder: (context,index)=>const SizedBox(
                              height: 10,
                            ),
                            itemCount: AppCubit.get(context).messages.length
                            ,
                          physics:const BouncingScrollPhysics(),
                        ),

                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 3,
                                      color: Colors.black12
                                  ),
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              child: TextFormField(
                                keyboardType:TextInputType.multiline,
                                textInputAction: TextInputAction.newline,
                                validator: (String?value){
                                  if(value!.isEmpty){
                                    return 'can not send empty message';
                                  }
                                  return null;
                                },
                                controller: messageController,
                                maxLines: null,

                                decoration:const InputDecoration(
                                    hintText: 'type your massage here...',
                                    border: InputBorder.none
                                ),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: defaultColor,
                                borderRadius: BorderRadius.circular(30)
                            ),
                            child: MaterialButton(
                              minWidth: 1,
                              onPressed:()async{
                               await globalKey.currentState!.validate();

                                AppCubit.get(context).sendMessage(
                                    receiverId: model.uId!,
                                    dateTime: DateTime.now().minute.toString(),
                                    text: messageController.text
                                );
                                listViewController.animateTo(
                                    listViewController.position.minScrollExtent,
                                    duration: Duration(seconds: 1),
                                    curve: Curves.fastOutSlowIn
                                ).then((value){messageController.clear();});


                              },
                              child:const  Icon(Icons.send,size: 20,color: Colors.white,),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                );
              },
                  fallback: (context){return const Center(child: CircularProgressIndicator());
              },

          ),
        ),
            );
  },
);
      }
    );
  }

  Widget buildYourMessages(MessageModel model)=>Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
        padding:const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5
        ),
        decoration:  BoxDecoration(
            color:Colors.grey[300],
            borderRadius:const BorderRadiusDirectional.only(
              topEnd:Radius.circular(10),
              bottomEnd:Radius.circular(10),
              topStart:Radius.circular(10),
            )
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 5,
            vertical: 10
          ),
          child: Text(model.text!),
        )),
  );
  Widget buildMyMessages(MessageModel model)=>Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
        padding:const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5
        ),
        decoration:  BoxDecoration(
            color: defaultColor.withOpacity(.2),
            borderRadius:const BorderRadiusDirectional.only(
              topStart:Radius.circular(10),
              bottomStart:Radius.circular(10),
              topEnd:Radius.circular(10),
            )
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 5,
            vertical: 10,),
          child: Text(model.text!),
        )),
  );
}
