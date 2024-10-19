  import 'dart:convert';

  import 'package:flutter/material.dart';
  import 'package:http/http.dart' as http;

  class PostTestPage extends StatefulWidget {
  const PostTestPage({super.key});

    @override
    State<PostTestPage> createState() => PostPageState();
  }

  class PostPageState extends State<PostTestPage> {
    var resultText = "";

    void postChange() async {
      var response = await http.post(
          Uri.parse("https://artvestserver-49b56a735f88.herokuapp.com/"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            "login": "Mukha",
            "queryType": "fetchProfileData",
            "tickerSymbol": "IBM",
            "amount": "10"
          })
      );
      print(response.body);
      setState(() {
        resultText = response.body;
      });
    }

    @override
    Widget build(BuildContext context) {
      return
        Scaffold(
            appBar: AppBar(
              title: const Text("Chat"),
              backgroundColor: const Color(0xFF007AFF),
            ),
            body: Column(
              children: [
                Text(resultText),
                OutlinedButton(onPressed: postChange, child: const Text("Send Post"))
              ]
            )
        );
    }
  }