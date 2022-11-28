
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import '../../models/alert/alert_model.dart';
import '../../models/user/UserDataModel.dart';
import '../../utils/ID/CreateId.dart';
import '../../utils/conestant/conestant.dart';
import 'firebase_options.dart';
class FirebaseReposatory {

  static FirebaseFirestore firebase = FirebaseFirestore.instance;

  static Future<void> initFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }


  Future<void> createUser({
    required String name,
    required String email,
    required String id,
    required String password,
    required String nationalID,
  }) async {
    UserDataModel userDataModel = UserDataModel(
      name,
      email,
      id,
      false,
      password,
      0,
      0,
      0,
      nationalID,
      "ب ت ع 111"
    );
    return firebase
        .collection('users')
        .doc(id)
        .set(userDataModel.toMap());
  }

  Future<UserCredential> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
   return FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<void> createAlert({
    required String name,
    required String id,
    required String nationalID,
    required String currentSpeed,
    required String preSpeed,
    required String carNumber,
    required String price,
  }) async {
    AlertData alertData = AlertData(
        name,
        id,
        currentSpeed,
        preSpeed,
        DateFormat("hh:mm a").format(DateTime.now()).toString(),
        DateFormat('MM/dd/yyyy').format(DateTime.now()).toString(),
        price,
        nationalID,
        carNumber);
    return firebase
        .collection('Infraction')
        .doc(id).collection('Infractions')
        .doc(CreateId.createId())
        .set(alertData.toMap());
  }

  Future<UserCredential> login({
    required String email,
    required String password,
  }) async{
    return FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> logout() async {
    FirebaseAuth.instance.signOut();
  }

  Future<UserCredential> loginInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserCredential> sginUpWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  void saveUserLocation(
  {
  required double lat,
  required double lng,
  required double speed,
}){
    firebase.collection('users').doc(constUid).update({
      'lat': lat,
      'lng': lng,
      'speed': speed,
    });   
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData(){
    return firebase.collection('users').doc(constUid).get();
  }

  
  void getUserLocation(){
    firebase.collection('users').doc(constUid).get();
  }

}