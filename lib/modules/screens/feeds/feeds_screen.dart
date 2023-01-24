import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:social_app/core/conponents/conponents.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/style/colors.dart';

class FeedsScreen extends StatelessWidget {
   const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit,AppStates>(
            builder: (context,state){
              var cubit= AppCubit.get(context);
              return ConditionalBuilder(
                    condition: cubit.posts.isNotEmpty && cubit.userModel!=null ,
                    builder: (context)=>SingleChildScrollView(
                      physics:const BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Card(
                                margin:const  EdgeInsets.only(bottom: 5),
                                elevation: 9.0,
                                child: Stack(
                                  children:const  [
                                    Image(
                                      width: double.infinity,
                                      height: 180,
                                      image: NetworkImage('https://img.freepik.com/premium-photo/young-woman-study-library-alone_386167-9162.jpg?w=740'),
                                      fit: BoxFit.cover,

                                    ),
                                    Positioned(
                                      bottom: 1,
                                      right: 1,
                                      child: Text('communicate with friends ',style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold
                                      ),),
                                    ),

                                  ],
                                )
                            ),
                            ListView.separated(
                                shrinkWrap: true,
                                physics:const NeverScrollableScrollPhysics(),
                                itemBuilder: (context,index){
                                  return (index > 0) ?buildPostItem(context,cubit.posts[index],index) : Container();
                                } ,
                                separatorBuilder:(context,index)=> const SizedBox(height: 10,),
                                itemCount:cubit.posts.length
                            ),
                            const SizedBox(
                              height: 10,
                            ),

                          ],
                        ),
                      ),
                    ),
                    fallback: (context)=>loadingPost()
                    );

            },
          );
      }
  }
  Widget buildPostItem(context,PostModel model,int index,)=>Card(
    margin: EdgeInsets.zero,
    elevation:15,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Profile Picture And Name And Date
        Row(
          children: [
            CircleAvatar(
              radius: 20.0,
              foregroundImage:NetworkImage('${model.image}',
              ),

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
                      const Icon(Icons.check_circle,
                        color:defaultColor,
                        size:15.0 ,

                      )
                    ],
                  ),
                  Text('${model.dateTime}',
                    style: Theme.of(context).textTheme.caption!.copyWith(
                        height:1.3
                    ),)
                ],
              ),
            ),
            IconButton(onPressed: (){}, icon:const Icon(Icons.more_horiz))
          ],
        ),
        //Line
        Padding(
          padding: const EdgeInsets.symmetric(
              vertical: 5
          ),
          child: Container(
            width: double.infinity,
            height: 1,
            color: Colors.grey ,
          ),
        ),
        //Title Post
        Text('${model.text}',
            maxLines: 4,
            style: Theme.of(context).textTheme.subtitle1),
        // Hashtags
        SizedBox(
          width: double.infinity,
          child: Wrap(

              children:[
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                      end: 6
                  ),
                  child: MaterialButton(
                    minWidth: 1,
                    height: 25,
                    padding: EdgeInsets.zero,
                    onPressed:(){},
                    child: Text('#software',
                      style: Theme.of(context).textTheme.caption!.copyWith(
                          color: defaultColor
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: 6),
                  child: MaterialButton(
                    height: 20,
                    minWidth: 1,
                    padding: EdgeInsets.zero,
                    onPressed:(){},
                    child: Text('#software',
                      style: Theme.of(context).textTheme.caption!.copyWith(
                          color: defaultColor
                      ),
                    ),
                  ),
                ),
              ]
          ),
        ),
        //Post Image
         if(model.postImage!=null)
        CachedNetworkImage(
          imageUrl: model.postImage!,
          fit: BoxFit.cover,
          height: 200,
          width: double.infinity,
          placeholder: (context, url) => Shimmer.fromColors(
            baseColor:Colors.grey,
            highlightColor: Colors.white,
            child:Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(5),
              ),
            ) ,
          ),
          errorWidget:(context, url, error) => const Icon(Icons.error),
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          children: [
            const Icon(Icons.favorite,
              color: Colors.red,
              size: 13,
            ),
            const SizedBox(
              width: 5,
            ),
            Text('${AppCubit.get(context).likes.isNotEmpty?
                AppCubit.get(context).likes[index]
            :""
            }',
              style: Theme.of(context).textTheme.caption,),
            const Spacer(),
            const Icon(Icons.chat_outlined,
              size: 13,
              color: Colors.amber,
            ),
            const SizedBox(
              width: 5,
            ),

              Text('${AppCubit.get(context).likes.isNotEmpty?
              AppCubit.get(context).likes[index]
                  :""
              }',
              style:Theme.of(context).textTheme.caption
              ,),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
              vertical: 8
          ),
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: (){
                    AppCubit.get(context).addComment(postId: AppCubit.get(context).postId[index]);
                  },
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 15,
                        backgroundImage:NetworkImage('${AppCubit.get(context).userModel!.image}'

                      ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        decoration:const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomRight:Radius.circular(15),
                                topRight:Radius.circular(15)
                            )
                        ),
                        child: Text('write a comment...',
                          style: Theme.of(context).textTheme.caption!.copyWith(
                              fontSize: 13
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  AppCubit.get(context).addLike( postId: AppCubit.get(context).postId[index]);
                },
                child: Row(
                  children: [
                    const Icon(Icons.favorite_outline,
                      color: Colors.red,
                      size: 13,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text('Like',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 10,
                          color: Colors.grey[600]
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

      ],
    ),
  );
