import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_class_pal/core/state/app_state.dart';
import 'package:flutter_class_pal/features/class/model/subject_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/utils/id_generator.dart';
import '../../post/model/post_model.dart';
import '../../teacher/model/teacher_model.dart';
import '../model/class_model.dart';
import 'package:http/http.dart' as http;

import '../model/score_model.dart';
import '../model/score_type_model.dart';

class ClassFirebase {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> _getUserIdFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId');
  }

  Future<List<ClassModel>> fetchClasses() async {
    try {
      String? userId = await _getUserIdFromSharedPreferences();
      print(userId);
      if (userId == null || userId.isEmpty) {
        throw Exception("User is not logged in or UID is not available");
      }

      var userDoc = await _firestore.collection('users').doc(userId).get();
      if (!userDoc.exists) {
        throw Exception("User not found");
      }

      var classIdsData = userDoc.data()?['classesIds'];
      List<String> classIds = [];
      if (classIdsData != null && classIdsData is List) {
        classIds = List<String>.from(classIdsData);
      } else {
        print("No 'classesIds' found or 'classesIds' is not a List.");
      }

      if (classIds.isEmpty) {
        throw Exception("No classes associated with the user");
      }

      List<ClassModel> classes = [];
      for (String classId in classIds) {
        DocumentSnapshot classDoc =
            await _firestore.collection('classes').doc(classId).get();
        if (classDoc.exists) {
          classes
              .add(ClassModel.fromMap(classDoc.data() as Map<String, dynamic>));
        } else {
          print("Class not found for classId: $classId");
        }
      }

      return classes;
    } catch (e) {
      print('Error fetching classes: $e');
      return [];
    }
  }

  Future<String> createClass(ClassModel newClass) async {
    try {
      String? currentUserId = await _getUserIdFromSharedPreferences();
      if (currentUserId == null || currentUserId.isEmpty) {
        throw Exception("User is not logged in");
      }

      var userDocSnapshot =
          await _firestore.collection('users').where(currentUserId).get();

      if (userDocSnapshot.docs.isEmpty) {
        throw Exception("User not found");
      }

      var userDoc = userDocSnapshot.docs.first;
      String userId = userDoc.data()['userId'];
      String newClassId = generateClassId();
      newClass = newClass.copyWith(classId: newClassId);

      await _firestore
          .collection('classes')
          .doc(newClassId)
          .set(newClass.toMap());

      await _firestore.collection('classes').doc(newClassId).update({
        'teacherIds': FieldValue.arrayUnion([userId]),
      });

      await _firestore.collection('users').doc(userDoc.id).update({
        'classesIds': FieldValue.arrayUnion([newClassId]),
      });

      return newClassId;
    } catch (e) {
      print('Error creating class: $e');
      return '';
    }
  }

  Future<String> createPost(String classId, PostModel newPost) async {
    try {
      String? currentUserId = await _getUserIdFromSharedPreferences();
      if (currentUserId == null || currentUserId.isEmpty) {
        throw Exception("User  is not logged in");
      }

      newPost = newPost.copyWith(user: AppState.getUser());

      // Thêm bài đăng vào trường 'posts' của lớp
      DocumentReference classRef =
          _firestore.collection('classes').doc(classId);
      await classRef.update({
        'posts': FieldValue.arrayUnion([newPost.toMap()]),
      });

      return 'Post added successfully';
    } catch (e) {
      print('Error creating post: $e');
      return '';
    }
  }

  Future<List<PostModel>> fetchPosts(String classId) async {
    try {
      var classDoc = await _firestore.collection('classes').doc(classId).get();

      if (!classDoc.exists) {
        throw Exception("Class not found");
      }

      var postsData = classDoc.data()?['posts'] as List<dynamic>? ?? [];
      List<PostModel> posts =
          postsData.map((post) => PostModel.fromMap(post)).toList();
      posts.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      return posts;
    } catch (e) {
      print('Error fetching posts: $e');
      return [];
    }
  }

  Future<String> createSubject(String name, List<String> scoreType) async {
    try {
      DocumentReference classRef =
          _firestore.collection('classes').doc(AppState.getClass()?.classId);

      // Lấy danh sách học sinh của lớp
      DocumentSnapshot classDoc = await classRef.get();
      List<Map<String, dynamic>> studentsList = List.from(classDoc['students']);

      // Tạo danh sách ScoreModel từ danh sách học sinh
      List<ScoreModel> scores = studentsList.map((student) {
        return ScoreModel(
          studentId: student['id'],
          studentName: student['name'],
          scoreTypes: scoreType
              .map((type) =>
                  ScoreTypeModel(typeName: type, score: 'Chưa có điểm', note: '',))
              .toList(),
        );
      }).toList();

      // Tạo đối tượng SubjectModel
      SubjectModel newSubject = SubjectModel(
        name: name,
        imageUrl: 'https://via.placeholder.com/150',
        scores: scores,
      );

      print(newSubject);

      // Cập nhật Firestore
      await classRef.update({
        'subjects': FieldValue.arrayUnion([newSubject.toMap()]),
      });

      return 'Subject created successfully';
    } catch (e) {
      if (kDebugMode) {
        print('Error creating subject: $e');
      }
      return '';
    }
  }

  Future<List<SubjectModel>> fetchSubjects() async {
    try {
      DocumentReference classRef =
          _firestore.collection('classes').doc(AppState.getClass()?.classId);

      // Lấy dữ liệu từ Firestore
      DocumentSnapshot classDoc = await classRef.get();

      if (classDoc.exists) {
        List<dynamic> subjectsList = List.from(classDoc['subjects']);
        List<SubjectModel> subjects = subjectsList
            .map((subjectMap) => SubjectModel.fromMap(subjectMap))
            .toList();
        return subjects;
      } else {
        return [];
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching subjects: $e');
      }
      return [];
    }
  }

  Future<String> inviteTeacher(String teacherEmail) async {
    try {
      if (teacherEmail.isEmpty) {
        throw Exception("Email của giáo viên không hợp lệ");
      }

      var url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
      String privateKey = 'v1lekQeXFZpQ62GBzmDWz';
      print(teacherEmail);

      // Gửi lời mời qua email
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'service_id': 'service_cofnw4r',
          'template_id': 'template_n08enpn',
          'user_id': '8N7GGBxT5kwkTUUzm',
          'accessToken': privateKey,
          'template_params': {
            'to_name': 'Giáo viên',
            'to_email': teacherEmail,
            'from_name': AppState.getUser()!.name,
            'message': AppState.getClass()!.classId,
          },
        }),
      );

      // Kiểm tra phản hồi từ API gửi email
      if (response.statusCode == 200) {
        String? currentClassId = AppState.getClass()?.classId;
        if (currentClassId == null) {
          throw Exception("Lớp học không hợp lệ");
        }

        TeacherModel newTeacher = TeacherModel(
          uid: null,
          role: 'Giáo viên',
          canEdit: false,
          email: teacherEmail,
          isActive: false,
        );
        DocumentReference classRef =
            _firestore.collection('classes').doc(currentClassId);
        await classRef.update({
          'teachers': FieldValue.arrayUnion([newTeacher.toMap()]),
          // Thêm giáo viên vào danh sách
        });

        return 'Lời mời đã được gửi thành công đến giáo viên!';
      } else {
        return 'Gửi lời mời thất bại: ${response.body}';
      }
    } catch (e) {
      print('Error inviting teacher: $e');
      return 'Có lỗi xảy ra khi gửi lời mời';
    }
  }

  Future<String> joinClass(String classId) async {
    try {
      // Get the current user's email
      String? currentUserEmail = AppState.getUser()?.email;
      if (currentUserEmail == null || currentUserEmail.isEmpty) {
        throw Exception("User is not logged in");
      }
      DocumentSnapshot classDoc =
          await _firestore.collection('classes').doc(classId).get();

      if (!classDoc.exists) {
        throw Exception("Class not found");
      }

      var classData = classDoc.data() as Map<String, dynamic>;
      var teachersData = classData['teachers'] as List<dynamic>? ?? [];
      List<TeacherModel> teachers = teachersData
          .map<TeacherModel>((teacherData) =>
              TeacherModel.fromMap(teacherData as Map<String, dynamic>))
          .toList();
      var teacherIndex =
          teachers.indexWhere((teacher) => teacher.email == currentUserEmail);

      if (teacherIndex != -1) {
        teachers[teacherIndex].isActive = true;
        teachers[teacherIndex].uid = AppState.getUser()?.userId;
        await _firestore.collection('classes').doc(classId).update({
          'teachers': teachers.map((teacher) => teacher.toMap()).toList(),
        });
        String? userId = await _getUserIdFromSharedPreferences();
        if (userId == null || userId.isEmpty) {
          throw Exception("User is not logged in or UID is not available");
        }

        DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(userId).get();
        if (!userDoc.exists) {
          throw Exception("User not found");
        }

        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
        List<String> classesIds =
            List<String>.from(userData['classesIds'] ?? []);
        if (!classesIds.contains(classId)) {
          classesIds.add(classId);
          await _firestore.collection('users').doc(userId).update({
            'classesIds': classesIds,
          });
        }

        return 'You have successfully joined the class and activated the teacher account!';
      } else {
        return 'Your email is not listed as a teacher in this class. You cannot join this class.';
      }
    } catch (e) {
      print('Error joining class: $e');
      return 'Error joining class: $e';
    }
  }
}
