import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;

class Charity {
  final String ID;
  final String name;
  final String info;

  Charity({required this.ID, required this.name, required this.info});

  factory Charity.fromJson(Map<String, dynamic> json) {
    return Charity(
      ID: json['ID'].toString(),
      name: json['name'],
      info: json['description'],
    );
  }
}

class CharityListPage extends StatefulWidget {
  @override
  _CharityListPageState createState() => _CharityListPageState();
}

class _CharityListPageState extends State<CharityListPage> {
  late Future<List<Charity>> futureCharities;

  @override
  void initState() {
    super.initState();
    futureCharities = loadCharities();
  }

  Future<List<Charity>> loadCharities() async {
    var response = await http.post(
        Uri.parse("https://artvestserver-49b56a735f88.herokuapp.com/"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "login": "Mukha",
          "queryType": "fetchCharityOrganizations",
          // "tickerSymbol": "IBM",
          // "amount": "10"
        })
    );
    print(response.body);
    setState(() {
    });

    // final jsonString = await rootBundle.loadString('assets/donation-info.json');
    final jsonString = response.body;
    final List<dynamic> jsonResponse = json.decode(jsonString)['organizations'];
    return jsonResponse.map((data) => Charity.fromJson(data)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Charities'),
      ),
      body: FutureBuilder<List<Charity>>(
        future: futureCharities,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No charities found'));
          } else {
            final charities = snapshot.data!;
            return ListView.builder(
              itemCount: charities.length,
              itemBuilder: (context, index) {
                final charity = charities[index];
                return CharityPost(charity: charity);
              },
            );
          }
        },
      ),
    );
  }
}

class CharityPost extends StatefulWidget {
  final Charity charity;

  CharityPost({required this.charity});

  @override
  _CharityPostState createState() => _CharityPostState();
}

class _CharityPostState extends State<CharityPost> {
  bool _showCode = false;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      height: screenHeight,
      width: screenWidth,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.charity.name,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.charity.info,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _showCode = !_showCode;
                    });
                  },
                  child: Text(_showCode ? 'Show less' : 'Show more'),
                ),
                if (_showCode)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.charity.ID,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}