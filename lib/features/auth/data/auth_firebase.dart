import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../core/utils/id_generator.dart';
import '../../user/model/user_model.dart';

class AuthFirebase {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // hàm đăng ký
  Future<UserModel?> registerUser(UserModel userModel, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: userModel.email,
        password: password,
      );
      User? user = userCredential.user;
      if (user != null) {
        String userId = generateUserId();
        UserModel newUser = userModel.copyWith(userId: userId);
        await _firestore.collection('users').doc(user.uid).set(newUser.toMap());

        return newUser;
      }
    } catch (e) {
      print("Error registering user: $e");
      return null;
    }
    return null;
  }

  // hàm đăng nhập
  Future<UserModel?> loginUser(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      print("User UID: ${user?.uid}");
      if (user != null) {
        DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(user.uid).get();
        if (userDoc.exists) {
          print("Document data: ${userDoc.data()}");
          return UserModel.fromMap(userDoc.data() as Map<String, dynamic>);
        } else {
          print("Document not found for UID: ${user.uid}");
        }
      }
    } catch (e) {
      print("Error logging in user: $e");
    }
    return null;
  }
}
