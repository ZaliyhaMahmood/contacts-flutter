import 'dart:async';

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

  Future getUsersByID(String id) async {
    //this function returns nothing
    Map result;
    await HttpHelpers() //this function returns res
        .getRequest('https://jsonplaceholder.typicode.com/posts/$id')
        .then((res) {
      // print(res);
      result = res;
      return res;
    });
    return result;
  }
}
