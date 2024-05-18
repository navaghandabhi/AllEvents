import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';

import '../models/user_data_model.dart';

class FirestoreServices {
  //region Users

  final CollectionReference _users = FirebaseFirestore.instance.collection('users');

  Future<String> addUser(UserData user) async {
    String id = "";
    await _users.where("email", isEqualTo: user.email).get().then((value) async {
      if (value.docs.isEmpty) {
        await _users.add(user.toJson()).then((value) {
          return id = value.id;
        });
      } else {
        id = value.docs.first.reference.id;
      }
    });
    return id;
  }

  Future<void> updateUser(String id, UserData user) async {
    await _users.doc(id).update(user.toJson());
  }

  Future<UserData> getUserData(String id) async {
    UserData userData = UserData();
    await _users.where("id", isEqualTo: id).get().then((doc) {
      if (doc.docs.isNotEmpty) {
        userData = UserData.fromJson(doc.docs.first.data() as Map<String, dynamic>, doc.docs.first.reference.id);
      } else {
        // print("User does not exist");
      }
    });
    return userData;
  }

  Future<UserData> getUserDataById(String id) async {
    UserData userData = UserData();
    await _users.doc(id).get().then((doc) {
      if (doc.exists) {
        userData = UserData.fromJson(doc.data() as Map<String, dynamic>, doc.reference.id);
      } else {
        // print("User does not exist");
      }
    });
    return userData;
  }

  Stream<UserData> listenUserData(String id) {
    return _users.where("id", isEqualTo: id).snapshots().map((event) {
      return UserData.fromJson(event.docs.first.data() as Map<String, dynamic>, event.docs.first.reference.id);
    });
  }

  Future<void> deleteUser(String id) async {
    await _users.doc(id).delete();
  }

  //endregion
}
