// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:messenger_clone/common.helper/shared_pre_helper.dart';
// import 'package:messenger_clone/services/auth/auth_service.dart';
//
// class AuthServiceIml implements AuthService {
//   FirebaseAuth auth = FirebaseAuth.instance;
//   User? userDetails;
//
//   static SnackBar customSnackBar({required String content}) {
//     return SnackBar(
//       backgroundColor: Colors.black,
//       content: Text(
//         content,
//         style: TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
//       ),
//     );
//   }
//
//   @override
//   Future<FirebaseApp> initializeFirebase({required BuildContext context}) {
//     // TODO: implement initializeFirebase
//     throw UnimplementedError();
//   }
//
//   @override
//   Future<User?> signInWithGoogle({required BuildContext context}) async {
//
//     if (kIsWeb) {
//       GoogleAuthProvider authProvider = GoogleAuthProvider();
//
//       try {
//         final UserCredential userCredential =
//             await auth.signInWithPopup(authProvider);
//
//         userDetails = userCredential.user;
//       } catch (e) {
//         print(e);
//       }
//     } else {
//       final GoogleSignIn googleSignIn = GoogleSignIn();
//
//       final GoogleSignInAccount? googleSignInAccount =
//           await googleSignIn.signIn();
//
//       if (googleSignInAccount != null) {
//         final GoogleSignInAuthentication googleSignInAuthentication =
//             await googleSignInAccount.authentication;
//
//         final AuthCredential credential = GoogleAuthProvider.credential(
//           accessToken: googleSignInAuthentication.accessToken,
//           idToken: googleSignInAuthentication.idToken,
//         );
//
//         try {
//           final UserCredential userCredential =
//               await auth.signInWithCredential(credential);
//
//           userDetails = userCredential.user;
//           SharedPreferenceHelper().saveUserEmail(userDetails!.email!);
//           // SharedPreferenceHelper().saveUserId(userDetails!.uid);
//           SharedPreferenceHelper().saveUserName(userDetails!.email!.replaceAll("@gmail.com", ""));
//           SharedPreferenceHelper().saveDisplayName(userDetails!.displayName!);
//           SharedPreferenceHelper().saveUserProfileUrl(userDetails!.photoURL!);
//
//           Map<String, dynamic> userInfoMap = {
//             "email": userDetails!.email,
//             "username": userDetails!.email!.replaceAll("@gmail.com", ""),
//             "name": userDetails!.displayName,
//             "imgUrl": userDetails!.photoURL,
//             "uid":userDetails!.uid,
//             "friends":[],
//             "conversations":[]
//           };
//
//           QuerySnapshot userData = await firebaseQuery.getUserByUserUID(userDetails!.uid.toString());
//           if(userData.docs.isEmpty) {
//             await firebaseQuery.addUserInfoToDB(userDetails!.uid, userInfoMap);
//             return userDetails;
//           }
//           else {
//             return userDetails;
//           }
//
//         } on FirebaseAuthException catch (e) {
//           if (e.code == 'account-exists-with-different-credential') {
//             ScaffoldMessenger.of(context).showSnackBar(
//               customSnackBar(
//                 content:
//                 'The account already exists with a different credential',
//               ),
//             );
//           } else if (e.code == 'invalid-credential') {
//             ScaffoldMessenger.of(context).showSnackBar(
//               customSnackBar(
//                 content:
//                 'Error occurred while accessing credentials. Try again.',
//               ),
//             );
//           }
//         } catch (e) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             customSnackBar(
//               content: 'Error occurred using Google Sign In. Try again.',
//             ),
//           );
//         }
//       }
//     }
//     return null;
// }
//
//   @override
//   Future<void> signOut({required BuildContext context}) async {
//     final GoogleSignIn googleSignIn = GoogleSignIn();
//
//     try {
//       if (!kIsWeb) {
//         await googleSignIn.signOut();
//       }
//       await FirebaseAuth.instance.signOut();
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         customSnackBar(
//           content: 'Error signing out. Try again.',
//         ),
//       );
//     }
//   }
//
//   @override
//   Future<User?> getCurrentUserSignIn() async {
//     User? user = FirebaseAuth.instance.currentUser;
//     return user;
//   }
//
// }