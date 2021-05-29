import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class AToZFirebaseUser {
  AToZFirebaseUser(this.user);
  final User user;
  bool get loggedIn => user != null;
}

AToZFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<AToZFirebaseUser> aToZFirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<AToZFirebaseUser>((user) => currentUser = AToZFirebaseUser(user));
