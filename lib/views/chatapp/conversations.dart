import 'package:flutter/material.dart';
import 'package:my_app/views/chatapp/chats.dart';

class Conversations extends StatefulWidget {
  const Conversations({super.key});

  @override
  State<Conversations> createState() => _State();
}

class _State extends State<Conversations> {
  listItem() {
    return GestureDetector(
      onTap: () {
        Navigator.of(
          context,
        ).push(MaterialPageRoute<void>(builder: (context) => Chats()));
      },
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.all(15),
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(15),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2f/Google_2015_logo.svg/1920px-Google_2015_logo.svg.png",
                fit: BoxFit.fill,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text("Milan Gurung"), Text("You have a new message.")],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 60),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text("Conversations"),
          ),
          listItem(),
          listItem(),
          listItem(),
        ],
      ),
    );
  }
}
