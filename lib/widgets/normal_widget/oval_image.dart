import 'package:flutter/material.dart';

class OvalImage extends StatelessWidget {
  final String imagePath;
  final double curveHeight;
  final bool isBottom;

  const OvalImage({
    required this.imagePath,
    this.curveHeight = 40.0,
    this.isBottom = true,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _CustomOvalClipper(curveHeight: curveHeight, isBottom: isBottom),
      child: Image.asset(
        imagePath,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}

class _CustomOvalClipper extends CustomClipper<Path> {
  final double curveHeight;
  final bool isBottom;

  _CustomOvalClipper({required this.curveHeight, required this.isBottom});

  @override
  Path getClip(Size size) {
    final path = Path();

    if (isBottom) {
      path.lineTo(0, size.height - curveHeight); // Điểm bắt đầu ở đáy
      path.quadraticBezierTo(
        size.width / 2, size.height + curveHeight, // Tạo điểm cong
        size.width, size.height - curveHeight, // Điểm kết thúc ở đáy
      );
      path.lineTo(size.width, 0); // Đóng đường viền ở góc trên phải
    } else {
      path.moveTo(0, curveHeight); // Điểm bắt đầu ở trên
      path.quadraticBezierTo(
        size.width / 2, 0, // Tạo điểm cong
        size.width, curveHeight, // Điểm kết thúc ở trên
      );
      path.lineTo(size.width, size.height); // Đóng đường viền ở đáy phải
      path.lineTo(0, size.height); // Đóng đường viền ở đáy trái
    }

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
