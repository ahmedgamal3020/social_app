

class AppUserModel{
  String? name;
  String? email;
  String? phone;
  String? uId;
  bool? isEmailVerified;
  String? bio;
  String? image;
  String? caver;
  AppUserModel({
    this.name,
    this.email,
    this.phone,
    this.uId,
    this.isEmailVerified,
    this.bio,
    required this.image,
    required this.caver,
});
  AppUserModel.fromJson(Map<String,dynamic>json){
    name=json['name'];
    email=json['email'];
    phone=json['phone'];
    uId=json['uId'];
    isEmailVerified=json['isEmailVerified'];
    bio=json['bio'];
     image=json['image'];
    caver=json['caver'];

}
  Map<String, dynamic> toMap(){
  return {
    'name':name,
    'email':email,
    'phone':phone,
    'uId':uId,
    'isEmailVerified':isEmailVerified,
    'bio':bio,
    'image':image,
    'caver':caver,

  };
  }

}