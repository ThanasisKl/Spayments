// import 'package:spayments/models/user.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class AuthService {

//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   // create user obj based on firebase user
//   MyUser? _userFromFirebaseUser(User user) {
//     return user != null ? MyUser(uid: user.uid) : null;
//   }

//   // register with email and password
//   Future registerWithEmailAndPassword(String email, String password) async {
//     try {
//       UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
//       User? user = result.user;
//       return _userFromFirebaseUser(user!);
//     } catch (error) {
//       print(error.toString());
//       return null;
//     } 
//   }

//   // sign out
//   Future signOut() async {
//     try {
//       return await _auth.signOut();
//     } catch (error) {
//       print(error.toString());
//       return null;
//     }
//   }

// }