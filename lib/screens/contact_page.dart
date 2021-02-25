import 'package:flutter/material.dart';
import 'package:contacts_app/helpers/users_stream_helper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:contacts_app/helpers/http_helper.dart';

class ContactPage extends StatefulWidget {
  final String id;

  ContactPage({@required this.id});

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  GetUsersStream getUsersStream = GetUsersStream();

  @override
  void initState() {
    //init state is redundant
    //hence future builder runs the funtion once it
    //open the screen
    // getUsersStream.getUsersByID(widget.id);
    super.initState();

    // updateUI(widget.locationWeather);
    //removed update UI FUNCTION!!
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
                future: getUsersStream.getUsersByID(widget.id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  if (snapshot.hasData) {
                    return Text(snapshot.data['body']);
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
