
class MessageModel{
  String? receiverId;
  String? senderId;
  String? dateTime;
  String? text;

  MessageModel({
    this.receiverId,
    this.dateTime,
    this.senderId,
    this.text,

  });
  MessageModel.fromJson(Map<String,dynamic>json){
    receiverId=json['receiverId'];
    dateTime=json['dateTime'];
    senderId=json['senderId'];
    text=json['text'];


  }
  Map<String, dynamic> toMap(){
    return {
      'receiverId':receiverId,
      'dateTime':dateTime,
      'senderId':senderId,
      'text':text,


    };
  }

}