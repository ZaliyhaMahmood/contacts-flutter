import 'dart:async';
import 'package:flutter/cupertino.dart';

import 'http_helper.dart';

StreamController usersController;

class GetUsersStream {
  getUsers() async {
    HttpHelpers()
        .getRequest('https://jsonplaceholder.typicode.com/posts')
        .then((res) async {
      usersController.add(res);
      return res;
    });
  }

  getUsersByID(int id) async {
    HttpHelpers()
        .getRequest('https://jsonplaceholder.typicode.com/posts/$id')
        .then((res) async {
      print(res);
      return res;
    });
  }
}
