import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _collectionReferenceUser =
      FirebaseFirestore.instance.collection('users');

  Future<Map<String, dynamic>> signUp(String username, String email,
      String password, String phoneNumber) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user == null) {
        throw Exception('User is null');
      }

      String? uid = userCredential.user?.uid;
      DocumentReference userRef = _collectionReferenceUser.doc(uid);
      final userData = <String, dynamic>{
        "id": uid,
        "username": username,
        "email": email,
        "phone": phoneNumber,
        "bio": "I love gardening"
      };

      await userRef.set(userData);
      return userData;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (userCredential.user == null) {
        throw Exception("User is null");
      }

      final uid = userCredential.user!.uid;
      if (uid.isEmpty) {
        throw Exception("Uid is null");
      }

      DocumentReference userRef = _collectionReferenceUser.doc(uid);
      final userData = await userRef.get();
      Map<String, dynamic> data =
          Map<String, dynamic>.from(userData.data() as Map<String, dynamic>);
      data["id"] = uid;
      print("UID: ${uid}");
      print("Data: ${userData.data()}");
      print("Data2: ${data}");
      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<Map<String, dynamic>> getUserData(String? uid) async {
    if (uid == null) {
      throw Exception("User is null");
    }

    DocumentReference userRef = _collectionReferenceUser.doc(uid);
    final userData = await userRef.get();
    return userData.data() as Map<String, dynamic>;
  }

  Future<void> updateUserData(String username, String bio, String uid) async {
    DocumentReference userRef = _collectionReferenceUser.doc(uid);
    try {
      await userRef.update({"username": username, "bio": bio});
    } catch (e) {
      rethrow;
    }
  }
}
