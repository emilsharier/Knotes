import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:knotes/main.dart';
import 'package:knotes/modelClasses/LoginStatus.dart';
import 'package:knotes/modelClasses/knote_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier {
  FirebaseUser _user;
  FirebaseAuth _auth;
  SharedPreferences _preference;

  bool _autoSync = false;

  Firestore databaseReference = Firestore.instance;

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  LoginStatus _loginStatus = LoginStatus.UnInitialized;

  LoginStatus get loginStatus => _loginStatus;
  FirebaseUser get currentUser => _user;
  bool get autoSync => _autoSync;

  UserProvider.instance() : _auth = FirebaseAuth.instance {
    _auth.onAuthStateChanged.listen(_onAuthStateChanged);
  }

  Future<bool> signInWithGoogle() async {
    try {
      _loginStatus = LoginStatus.Authenticating;
      notifyListeners();
      await _internalSignInCall();
      return true;
    } catch (e) {
      _loginStatus = LoginStatus.UnAuthenticated;
      notifyListeners();
      return Future.delayed(Duration.zero);
    }
  }

  Future _internalSignInCall() async {
    final GoogleSignInAccount _googleSignInAccount =
        await _googleSignIn.signIn();
    final GoogleSignInAuthentication _googleSignInAuthentication =
        await _googleSignInAccount.authentication;

    final AuthCredential _credentials = GoogleAuthProvider.getCredential(
      accessToken: _googleSignInAuthentication.accessToken,
      idToken: _googleSignInAuthentication.idToken,
    );

    final AuthResult _result = await _auth.signInWithCredential(_credentials);
    final FirebaseUser _user = _result.user;
    final FirebaseUser _currentUser = await _auth.currentUser();

    assert(!_user.isAnonymous);
    assert(await _user.getIdToken() != null);
    assert(_user.uid == _currentUser.uid);

    print("Logged in as " + _currentUser.email);
  }

  Future signOut() async {
    _loginStatus = LoginStatus.LoggingOut;
    notifyListeners();
    await Future.delayed(Duration(seconds: 1));
    await _auth.signOut();
    _loginStatus = LoginStatus.UnAuthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future<void> _onAuthStateChanged(FirebaseUser user) async {
    if (user == null) {
      _loginStatus = LoginStatus.UnAuthenticated;
    } else {
      _user = user;
      _loginStatus = LoginStatus.Authenticated;
    }
    notifyListeners();
  }
}
