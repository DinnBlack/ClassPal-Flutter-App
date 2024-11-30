import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/constants/constant.dart';
import '../../../../core/utils/app_text_style.dart';
import '../../../../core/widgets/common_widget/custom_app_bar.dart';
import '../../model/class_model.dart';

class ClassMessagePage extends StatefulWidget {
  static const route = 'ClassMessagePage';
  final ClassModel classData;

  const ClassMessagePage({super.key, required this.classData});

  @override
  _ClassMessagePageState createState() => _ClassMessagePageState();
}

class _ClassMessagePageState extends State<ClassMessagePage> {
  List<types.Message> _messages = []; // Danh sách tin nhắn

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Tin Nhắn',
        leading: const FaIcon(
          FontAwesomeIcons.arrowLeft,
          size: 20,
        ),
        titleStyle: AppTextStyle.bold(kTextSizeXl),
        isTitleCenter: true,
      ),
      body: Chat(
        messages: _messages,
        onSendPressed: _handleSendPressed,
        user: types.User(id: 'user_id'), // Thay đổi user_id thành ID người dùng thực tế
        showUserAvatars: true,
        showUserNames: true,
        // Bạn có thể thêm nhiều tùy chọn khác tại đây
      ),
    );
  }

  void _handleSendPressed(types.PartialText message) {
    final newMessage = types.TextMessage(
      author: types.User(id: 'user_id'), // Thay đổi user_id thành ID người dùng thực tế
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: message.text,
    );

    setState(() {
      _messages.insert(0, newMessage); // Thêm tin nhắn mới vào đầu danh sách
    });
  }
}