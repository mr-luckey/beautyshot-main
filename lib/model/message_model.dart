
class MessageModel{
  String sender,receiver,message,msgId,msgImage;
  final DateTime createdAt;


  MessageModel(this.sender, this.receiver, this.message, this.msgId, this.msgImage,
      this.createdAt);

  Map<String, dynamic> toMap() {
    return {
      'sender': sender,
      'receiver': receiver,
      'message': message,
      'msgId': msgId,
      'msgImage': msgImage,
      'createdAt': createdAt,

    };
  }
  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      map['sender'] as String,
      map['receiver'] as String,
      map['message'] as String,
      map['msgId'] as String,
      map['msgImage'] as String,
      map['createdAt'] as DateTime,
    );
  }
}