import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:contacts_app/helpers/users_stream_helper.dart';
import 'dart:async';
import 'package:contacts_app/screens/contact_page.dart';

const kBlue = Color(0xFF2A549C);
const kLight1 = Color(0xFFEDF0F7);
const kLight2 = Color(0xFFFAFBFF);
int id;

class Contacts extends StatefulWidget {
  @override
  _ContactsState createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  GetUsersStream getUsersStream = GetUsersStream();

  @override
  void initState() {
    // TODO: implement initState
    usersController = StreamController();
    getUsersStream.getUsers();
    // getUsersStream.getUsersByID(2);
    super.initState();
//    fetchContacts();
    //  print('this method has been called');
  }

  // Future<List<dynamic>> fetchContacts() async {
  //   final response = await http
  //       .get('https://api.mockaroo.com/api/f513edc0?count=50&key=966a4f00');
  //
  //   if (response.statusCode == 200) {
  //     List<dynamic> post = jsonDecode(response.body);
  //     //  print('zz');
  //     return post;
  //   } else {
  //     throw Exception('Failed to load post');
  //   }
  // }

  String _name(dynamic user) {
    return user['first_name'] + " " + user['last_name'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.menu,
              color: kBlue,
            ),
            Row(
              children: [
                Text(
                  'Contacts',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black,
                ),
              ],
            ),
            Icon(
              Icons.add,
              color: kBlue,
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          child: StreamBuilder(
            stream: usersController.stream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.only(left: 15),
                      height: 40,
                      decoration: BoxDecoration(
                        color: kLight1,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            (Icons.search),
                            color: Colors.grey,
                          ),
                          Text(
                            ' Search',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 20),
                      color: kLight2,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 350.0),
                            child: Icon(
                              CupertinoIcons.question_circle_fill,
                              color: Colors.grey[700],
                            ),
                          ),
                          Text(
                            'Total',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            snapshot.data.length.toString(),
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Friends',
                            style: TextStyle(
                              fontSize: 20,
                              color: kBlue,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: ListView.builder(
                          padding: EdgeInsets.all(8),
                          itemCount: snapshot.data.length ??
                              0, //so that the list knows how many items to show
                          itemBuilder: (BuildContext context, int index) {
                            var userData = snapshot.data[index];
                            return Column(
                              children: <Widget>[
                                // FlatButton(
                                //   onPressed: () {
                                //     // getUsersStream.getUsersByID(userData['id']);
                                //     // var postData = getUsersStream
                                //     //     .getUsersByID(userData['id'])
                                //     //     .toString();

                                //     );
                                //     //print(userData);
                                //   },
                                //   child:
                                ListTile(
                                  // 1. list tile has an ontap
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ContactPage(
                                          id: userData['id'].toString(),
                                        ),
                                      ),
                                    );
                                  },
                                  // leading: CircleAvatar(
                                  //     radius: 20,
                                  //     backgroundImage: NetworkImage(
                                  //         userData['Profile_image'])),
                                  title: Text(
                                    // _name(userData),
                                    userData['id'].toString(),
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(userData['title']),
                                      Text(
                                        userData['body'],
                                        style: TextStyle(
                                          color: kBlue,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  trailing: Text(userData['userId'].toString()),
                                ),

                                SizedBox(
                                  height: 10,
                                  child: Divider(
                                    thickness: 1,
                                  ),
                                ),
                              ],
                            );
                          }),
                    ),
                  ],
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
