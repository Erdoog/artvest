import 'package:flutter/material.dart';

class PersonalAccountWidget extends StatefulWidget {
  @override
  _PersonalAccountWidgetState createState() => _PersonalAccountWidgetState();
}

class _PersonalAccountWidgetState extends State<PersonalAccountWidget> {
  String userName = "User";
  String profilePictureUrl = "assets/default_pfp.jpg";

  void _changeUserName() {
    // napishi logiku po smene mne len
  }

  void _changeProfilePicture() {
    // napishi logiku po smene ya hz kak
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30), // eto otstup sverhu default = 50
              Row(
                children: [
                  GestureDetector(
                    onTap: _changeProfilePicture,
                    child: CircleAvatar(
                      radius: 30, // eto radius pfp-shki default = 40
                      backgroundImage: AssetImage(profilePictureUrl),
                      onBackgroundImageError: (_, __) {
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  GestureDetector(
                    onTap: _changeUserName,
                    child: Text(
                      userName,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {
                    // hren dlya achievements (nado logiku propisat')
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    textStyle: const TextStyle(
                      fontSize: 16,
                      decoration: TextDecoration.underline,
                      color: Colors.white,
                    ),
                  ),
                  child: const Text("Achievements"),
                ),
              ),
              const SizedBox(height: 16),
              _buildTableSection(
                title: "Open positions",
                columns: ["symbol", "qty", "p paid", "p/l %", "value"],
                rowCount: 5,
                columnCount: 5,
              ),
              const SizedBox(height: 16),
              _buildTableSection(
                title: "Watchlist",
                columns: ["symbol", "exc", "last p", "chg %"],
                rowCount: 2,
                columnCount: 4,
              ),
              const SizedBox(height: 16),
              _buildTableSection(
                title: "Transaction history",
                columns: ["symbol", "qty", "p/l %", "value", "status"],
                rowCount: 5,
                columnCount: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTableSection({
    required String title,
    required List<String> columns,
    required int rowCount,
    required int columnCount,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white, // Sdelay text belim
          ),
        ),
        const SizedBox(height: 8),
        Table(
          border: const TableBorder(
            horizontalInside: BorderSide(color: Colors.white),
            bottom: BorderSide(color: Colors.white),
          ),
          columnWidths: {for (var i = 0; i < columnCount; i++) i: const FlexColumnWidth()},
          children: [
            TableRow(
              decoration: const BoxDecoration(),
              children: columns.map((column) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    column,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              }).toList(),
            ),
            for (int i = 0; i < rowCount; i++)
              TableRow(
                children: List.generate(columnCount, (index) {
                  return Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        left: BorderSide(color: Colors.white),
                        right: BorderSide(color: Colors.white),
                        bottom: BorderSide(color: Colors.white),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Data ${i + 1}.${index + 1}", // Sample data
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white, // Grey text color
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }),
              ),
          ],
        ),
      ],
    );
  }
}
