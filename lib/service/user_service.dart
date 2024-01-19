import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covoiturage/model/user_model.dart';

class UserService {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future<UserModel?> getUserByUid(String uid) async {
    try {
      var querySnapshot =
          await usersCollection.where('uid', isEqualTo: uid).get();
      var document = querySnapshot.docs.first;
      return UserModel.fromJson(document.data() as Map<String, dynamic>);
    } catch (error) {
      print('Error getting user by UID: $error');
      return null;
    }
  }

  Future<void> updateUserByUid(String uid, UserModel userModel) async {
    try {
      await usersCollection.doc(uid).update(userModel.toJson());
    } catch (error) {
      print('Error updating user by UID: $error');
    }
  }
}
