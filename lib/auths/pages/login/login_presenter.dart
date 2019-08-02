
import 'package:projetsalon/auths/data/database_helper.dart';
import 'package:projetsalon/auths/data/rest_data.dart';
import 'package:projetsalon/auths/models/user.dart';

abstract class LoginPageContract {
  void onLoginSuccess(User user);
  void onLoginError(String error);
}

class LoginPagePresenter {
  LoginPageContract _view;
  RestData api = new RestData();
  LoginPagePresenter(this._view);

  doLogin(String username, String password,  String nomsalon,String localisation,String numero, String lon, String lat, String img) {
    //print("HI");
    var db = new DatabaseHelper();
    db.checkUser(User(username, password, nomsalon,localisation, numero, lon, lat, img)).
        then((user) => _view.onLoginSuccess(user))
        
        .catchError((onError) {
          //print("Trying to Catch"+onError.toString());
          return _view.onLoginError(onError.toString());
        });

  }
}
