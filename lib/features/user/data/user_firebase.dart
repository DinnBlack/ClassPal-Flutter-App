import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/user_model.dart';

class UserFirebase {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<UserModel?> getUser() async {
    try {
      User? firebaseUser = _auth.currentUser;
      if (firebaseUser != null) {
        DocumentSnapshot userDoc = await _firestore.collection('users').doc(firebaseUser.uid).get();

        if (userDoc.exists) {
          return UserModel.fromMap(userDoc.data() as Map<String, dynamic>);
        } else {
          print("Không tìm thấy thông tin người dùng trong Firestore");
          return null;
        }
      } else {
        final prefs = await SharedPreferences.getInstance();
        String? userId = prefs.getString('userId');
        if (userId != null && userId.isNotEmpty) {
          DocumentSnapshot userDoc = await _firestore.collection('users').doc(userId).get();
          if (userDoc.exists) {
            return UserModel.fromMap(userDoc.data() as Map<String, dynamic>);
          } else {
            print("Không tìm thấy thông tin người dùng trong Firestore");
            return null;
          }
        } else {
          print("Người dùng chưa đăng nhập và không có userId trong SharedPreferences");
          return null;
        }
      }
    } catch (e) {
      print("Lỗi khi lấy thông tin người dùng: $e");
      return null;
    }
  }
}
