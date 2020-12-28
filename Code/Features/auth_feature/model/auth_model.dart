import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'result.dart';
import 'utilisateur.dart';
import 'auth_state.dart';

export 'result.dart';
export 'utilisateur.dart';
export 'auth_state.dart';


/////////////////////////////////////////////////////////////////////////////////////////////
///  Auth Model
/////////////////////////////////////////////////////////////////////////////////////////////

class AuthModel{

  ////////////////////////////////////////////////////////////////
  // Inputs

  // Sign In
  Future<Result> signIn({@required email, @required password}) async {
    return FirebaseAuth.instance.signOut().then((value) => FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) => Success() as Result)
        .catchError((e) => Failure(message: e.message)));
  }

  // SignOut
  signOut() {
    FirebaseAuth.instance.signOut();
  }

  // Create User
  Future<Result> createUser(
      {@required email, @required password, @required username}) {
    return FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((user) {
      final newUser = Utilisateur(
          userId: user.user.uid,
          email: email,
          username: username,
          imageId: 'default_profile_image.png',
          isAdmin: false);
      return FirebaseFirestore.instance
          .collection(Utilisateur.collectionRef)
          .doc(user.user.uid)
          .set(newUser.toEntity())
          .then((docRef) => Success() as Result)
          .catchError((e) => Failure(message: e.message));
    }).catchError((e) => Failure(message: e.message));
  }

  // Get Auth state stream
  ValueStream<AuthState> getAuthStateStream() {
    return FirebaseAuth.instance.authStateChanges().map((user) {
      if (user == null) {
        return NoUserLoggedIn();
      } else {
        return UserLoggedIn(currentUserStream: getUserStream(user.uid));
      }
    }).shareValue();
  }

  // Get User Stream
  ValueStream<Utilisateur> getUserStream(String userId) {
    return FirebaseFirestore.instance
        .collection(Utilisateur.collectionRef)
        .doc(userId)
        .snapshots()
        .map((docSnapsot) {
      return Utilisateur.fromEntity(docSnapsot.data());
    }).shareValue();
  }
}