import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class CopiaProyectoFirebaseUser {
  CopiaProyectoFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

CopiaProyectoFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<CopiaProyectoFirebaseUser> copiaProyectoFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<CopiaProyectoFirebaseUser>(
            (user) => currentUser = CopiaProyectoFirebaseUser(user));
