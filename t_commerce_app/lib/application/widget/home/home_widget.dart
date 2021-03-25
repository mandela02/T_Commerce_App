import 'package:flutter/material.dart';

class HomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        elevation: 0,
        title: Text(
          "Home",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Text("Home page"),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.red,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "HaniPla",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            getHeader("Management"),
            getCell(context, "Order", onClick: () {}),
            getCell(context, "Product", onClick: () {}),
            SizedBox(
              height: 20,
            ),
            getHeader("Settings"),
            getCell(context, "Settings", onClick: () {}),
          ],
        ),
      ),
    );
  }

  Widget getCell(BuildContext context, String text, {Function onClick}) {
    return ListTile(
      title: Text(
        text,
        style: TextStyle(
          fontSize: 20,
          color: Colors.black,
        ),
      ),
      onTap: () {
        onClick;
        Navigator.pop(context);
      },
    );
  }

  Widget getHeader(String text) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 15,
          color: Colors.grey[800],
        ),
      ),
    );
  }
}
