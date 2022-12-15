
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget myDivider()=>Container(
  width: double.infinity,
  height: 2,
  color: Colors.grey[300],
);

Future navigateAndFinish(context,widget)=>Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context)=>widget),
        (route) => false);

Future navigateTo(context,widget)=>Navigator.push(
    context,
    MaterialPageRoute(builder: (context)=>widget
    )

);
PreferredSizeWidget? defaultAppBar({
  Widget? title,
  List<Widget>? actions,
  Widget? leading,
  bool centerTitle=false,
  double elevation=8,
})=>AppBar(
  title:title!,
  actions:actions,
  leading:leading ,
  centerTitle:centerTitle,
  elevation:elevation,

);

Widget defaultIconButton({
  @required  onPressed,
  @required Widget? icon,
  EdgeInsetsGeometry padding=EdgeInsets.zero,
  Color? color,
  ButtonStyle? style,
})=>IconButton(
    onPressed: onPressed,
    icon: icon!,
  padding:padding,
  color:color ,
  style:style ,

);
Widget defaultTextFromFiled({
  @required TextEditingController? controller,
  @required String? Function(String?)? validator,
  @required TextInputType? keyboardType,
  Function(String)? onChanged,
  Function()? onTap,
  void Function(String)? onFieldSubmitted,
  @required Icon? prefixIcon,
  @required String? label,
  InputBorder? border,
  int maxLines=1,
  TextStyle? style,
  IconButton? suffixIcon,
  bool obscureText=false,
  bool?enabled,
}
    )=>TextFormField(
  controller:controller ,
  enabled:enabled ,
  validator:validator ,
  keyboardType:keyboardType ,
  onChanged:onChanged ,
  onTap:onTap ,
  onFieldSubmitted: onFieldSubmitted,
  maxLines:maxLines ,
  style: style,
  obscureText:obscureText,
  decoration:InputDecoration(
    prefixIcon: prefixIcon,
    suffixIcon:suffixIcon,

    label: Text(label!),
    border:border,

  ) ,

);


Widget defaultButton({
  @required void Function()? onPressed,
  @required String? text,
  MaterialStateProperty<Color?>?bgColor,
  MaterialStateProperty<double?>? elevation,
  double?width,
  double?height,
})=>SizedBox(
  width:width ,
  height:height,
  child:ElevatedButton(
    onPressed:onPressed ,
    style: ButtonStyle(
      backgroundColor: bgColor,
      elevation: elevation,
    ),
    child:Text(text!),
  ),
);

Widget defaultTextButton({
  @required void Function()? onPressed,
  @required String? text,
  double?fontSize,
  Color? color
})=> TextButton(
    onPressed:onPressed,
    child:Text(text!,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
      ),
    )
);

void defaultToast({
  required ToastState state,
  required dynamic text,

})=>Fluttertoast.showToast(
  msg:text,
  backgroundColor: chooseColor(state),
  fontSize: 16,
  gravity: ToastGravity.BOTTOM,
  timeInSecForIosWeb: 5,
  toastLength: Toast.LENGTH_LONG,
  textColor: Colors.white,
);

enum ToastState {success,error,warning}

Color chooseColor(ToastState state)
{
  Color color;

  switch(state)
  {
    case ToastState.success
        :color=Colors.green;
    break;

    case ToastState.error
        :color=Colors.red;
    break;

    case ToastState.warning
        :color=Colors.amber;
    break;

  }
  return color;
}
