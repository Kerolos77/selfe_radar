import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';
import 'package:selfe_radar/utils/cach_helper/cache_helper.dart';

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
    required String carNumber,
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
        carNumber);
    return firebase.collection('users').doc(id).set(userDataModel.toMap());
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
    required String address,
  }) async {
    String s = CreateId.createId();
    AlertData alertData = AlertData(
      name,
      id,
      currentSpeed,
      preSpeed,
      DateFormat("MM/dd/yyyy hh:mm a").format(DateTime.now()).toString(),
      price,
      nationalID,
      carNumber,
      s,
      address,
    );
    firebase.collection('Infraction').doc(id).set({"documentId": id});
    return firebase
        .collection('Infraction')
        .doc(id)
        .collection('Infractions')
        .doc(s)
        .set(alertData.toMap());
  }

  void deleteAlert({
    required id,
    required docID,
  }) {
    firebase
        .collection('Infraction')
        .doc(id)
        .collection('Infractions')
        .doc(docID)
        .delete();
  }

  Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    return FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> logout() async {
    FirebaseAuth.instance.signOut();
  }

  void saveUserLocation({
    required double lat,
    required double lng,
    required double speed,
  }) {
    firebase.collection('users').doc(constUid).update({
      'lat': lat,
      'lng': lng,
      'speed': speed,
    });
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData() {
    return firebase.collection('users').doc(constUid).get();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getAdminData() {
    return firebase.collection('users').doc(constUid).get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getUserInfractionsData() {
    var d = firebase
        .collection('Infraction')
        .doc(CacheHelper.getData(key: 'user'))
        .collection('Infractions')
        .orderBy("history", descending: true)
        .get();
    d.then((value) {
      value.docs[0].data()['preSpeed'];
    });
    return firebase
        .collection('Infraction')
        .doc(CacheHelper.getData(key: 'user'))
        .collection('Infractions')
        .orderBy("history", descending: true)
        .get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getAdminInfractionsData() {
    return firebase.collection('Infraction').get();
  }

}
