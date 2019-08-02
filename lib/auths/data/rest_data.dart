import 'dart:async';

import 'package:projetsalon/auths/models/user.dart';
import 'package:projetsalon/auths/utils/network_util.dart';


class RestData{
  NetworkUtil _netUtil = new NetworkUtil();
  static final BASE_URL = "";
  static final LOGIN_URL = BASE_URL + "/";
  //You can use this to login into a web service We are still working on it

  Future<User> login(String username, String password,  String nomsalon,String localisation,String numero, String lon, String lat, String img) {
    //expected success from web service
    return new Future.value(new User(username, password, nomsalon,localisation, numero, lon, lat, img));

  }
  Future<User> register(String username, String password,  String nomsalon,String localisation,String numero, String lon, String lat, String img) {
    //expected success from web service
    return new Future.value(new User(username, password, nomsalon,localisation, numero, lon, lat, img));
  }
    Future<User> delete(String username, String password,  String nomsalon,String localisation,String numero, String lon, String lat, String img) {
    //expected success from web service
    return new Future.value(new User(username, password, nomsalon,localisation, numero, lon, lat, img));
  }
}
