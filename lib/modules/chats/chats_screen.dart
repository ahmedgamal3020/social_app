import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/conponents/conponents.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/social_user_model.dart';
import 'package:social_app/modules/chat_details/chat_details.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return ConditionalBuilder(
      condition: AppCubit.get(context).users.isNotEmpty,
      fallback: (context) => const Center(child: CircularProgressIndicator()),
      builder: (context)=> ListView.separated(
          physics:const BouncingScrollPhysics(),
          itemBuilder: (context,index){
            return buildItemUsers(AppCubit.get(context).users[index],context);
          },
          separatorBuilder:(context,index)=> Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: myDivider(),
          ),
          itemCount: AppCubit.get(context).users.length

      ),
    );
  },
);
  }
  Widget buildItemUsers(AppUserModel model,context)=>InkWell(
    onTap: ()async{
      await AppCubit.get(context).getMessages(receiverId: model.uId!);
      print('Success');
      await navigateTo(context,ChatDetailsScreen(model: model)).then((value)async {


      });
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
              radius: 20.0,
              foregroundImage:NetworkImage('${model.image}',
              )
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('${model.name}',
                      style:const  TextStyle(
                          height: 1.3
                      ),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                  ],
                ),

              ],
            ),
          ),
        ],
      ),
    ),
  );
}
