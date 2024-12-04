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

  Future<UserModel?> getUserById(String userId) async {
    if (userId.isEmpty) {
      print("ID người dùng không hợp lệ (trống).");
      return null;
    }

    try {
      // Truy vấn người dùng dựa trên field 'userId'
      QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .where('userId', isEqualTo: userId)
          .limit(1)
          .get();

      // Kiểm tra xem truy vấn có dữ liệu không
      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot userDoc = querySnapshot.docs.first;
        return UserModel.fromMap(userDoc.data() as Map<String, dynamic>);
      } else {
        print("Không tìm thấy người dùng với userId $userId trong Firestore.");
        return null;
      }
    } on FirebaseException catch (e) {
      print("Lỗi Firestore khi lấy thông tin người dùng với userId $userId: ${e.message}");
      return null;
    } catch (e) {
      print("Lỗi không xác định khi lấy thông tin người dùng với userId $userId: $e");
      return null;
    }
  }
}
