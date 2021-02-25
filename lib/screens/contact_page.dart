import 'package:flutter/material.dart';
import 'package:contacts_app/helpers/users_stream_helper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:contacts_app/helpers/http_helper.dart';

class ContactPage extends StatefulWidget {
  final int id;

  ContactPage({@required this.id});

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  GetUsersStream getUsersStream = GetUsersStream();
  String body;
  @override
  void initState() {
    // TODO: implement initState
    getUsersStream.getUsersByID(widget.id);
    updateUI();
    super.initState();

    // updateUI(widget.locationWeather);
  }

  Future updateUI() async {
    var data = await getUsersStream.getUsersByID(widget.id);
    body = data.toString();
    print(body);
  }

  Widget build(BuildContext context) {
    //  getUsersStream.getUsersByID(widget.id);
    return Scaffold(
      backgroundColor: Colors.teal,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.id.toString()),
            FutureBuilder<dynamic>(
                future: updateUI(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data[0]);
                  } else if (!snapshot.hasData) {
                    return Text('No data');
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }

                  return CircularProgressIndicator();
                }),
            // Text(
            //   'name',
            //   style: TextStyle(
            //     fontFamily: 'Pacifico',
            //     fontSize: 40,
            //     color: Colors.white,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            // Text(
            //   'gender',
            //   style: TextStyle(
            //     fontFamily: 'Source Sans Pro',
            //     fontSize: 20,
            //     letterSpacing: 2.5,
            //     color: Colors.teal[100],
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
