import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Chats extends StatefulWidget {
  const Chats({super.key});

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  late TextEditingController _textEditingController;
  String chadId = "123";
  String currentUserId = "456";
  String otherUserId = "789";
  String firebaseCollection = 'chats';
  String messagesCollection = 'messages';
  Stream<QuerySnapshot>? messageStream;

  sendMessage(String text) async {
    final messageref = FirebaseFirestore.instance
        .collection(firebaseCollection)
        .doc(chadId)
        .collection(messagesCollection).doc();

    await messageref.set({
      'senderId': currentUserId,
      'text': text.trim(),
      'timestamp': FieldValue.serverTimestamp(),
    });

    await FirebaseFirestore.instance
        .collection(firebaseCollection).doc(chadId)
        .update({
          'lastMessage': text.trim(),
          'lastUpdated': FieldValue.serverTimestamp(),
        }
    );
  }

  Stream<QuerySnapshot> getMessage(){
    return FirebaseFirestore.instance
        .collection(firebaseCollection).doc(chadId)
        .collection(messagesCollection)
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
  @override
  void initState(){
    super.initState();
    _textEditingController = TextEditingController();
    messageStream = getMessage();
  }

  leftSideChat(Size size, String message){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: size.width/1.5,
          margin: EdgeInsets.only(left: 15, bottom: 15),
          padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
          decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(15)
          ),
          child: Text(message,
            style: TextStyle(color: Colors.white),),
        )
      ],
    );
  }

  rightSideChat(Size size, String message){
    return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: size.width/1.5,
            margin: EdgeInsets.only(left: 15, bottom: 15),
            padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
            decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(15)
            ),
            child: Text(message,
              style: TextStyle(color: Colors.white),),
          )
        ],
      );

  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 60,),
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Padding(padding: const EdgeInsets.all(20.0),
                  child: Icon(Icons.arrow_back, size: 35, color: Colors.black,),),
              ),
              StreamBuilder<QuerySnapshot>(stream: messageStream,
                  builder: (context, snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return const CircularProgressIndicator();
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty){
                      return const Text('No data available');
                    }
                    final messages = snapshot.data!.docs;
                    return Container(
                      width: size.width,
                      height: size.height/3,
                      child: ListView.builder(
                          padding: EdgeInsets.only(bottom: 5),
                          itemCount: messages.length,
                          itemBuilder: (context, index){
                            var msg = messages[index];
                            final isMe = msg['senderId'] == currentUserId;
                            return isMe? rightSideChat(size, msg['text']) : leftSideChat(size, msg['text']);
                          }
                      ),
                    );
                  }
              ),
            ],
          ),
          Column(
            children: [
              Container(
                color: Colors.black12,
                child: Row(
                  children: [
                    Container(
                      width: size.width/1.2,
                      child: TextField(
                        controller: _textEditingController,
                        style: TextStyle(),
                        onSubmitted: (var abc){

                        },
                        onEditingComplete: (){

                        },
                      ),
                    ),
                    SizedBox(width: 10,),
                    GestureDetector(
                      onTap: (){
                        var abc = _textEditingController.text;
                        sendMessage(abc);
                        setState(() {
                          _textEditingController.clear();
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Icon(Icons.send, color: Colors.white, size: 25,),),
                    )
                  ],),
              )
            ],
          )
          
        ],
      ),
    );
  }
}
