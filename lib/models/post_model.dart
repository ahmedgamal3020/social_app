
class PostModel{
  String? name;
  String? uId;
  String? image;
  String? postImage;
  String? dateTime;
  String? text;
  PostModel({
    this.name,
    this.uId,
    this.image,
    this.postImage,
    this.text,
    this.dateTime,

  });
  PostModel.fromJson(Map<String,dynamic>json){
    name=json['name'];
    uId=json['uId'];
    image=json['image'];
    postImage=json['postImage'];
    text=json['text'];
    dateTime=json['dateTime'];
  }
  Map<String, dynamic> toMap(){
    return {
      'name':name,
      'uId':uId,
      'image':image,
      'postImage':postImage,
      'text':text,
      'dateTime':dateTime,

    };
  }


}
