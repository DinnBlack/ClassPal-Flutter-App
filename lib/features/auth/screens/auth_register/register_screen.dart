import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/constants/constant.dart';
import '../../../../core/state/app_state.dart';
import '../../../../core/utils/app_text_style.dart';
import '../../../../core/widgets/common_widget/custom_button.dart';
import '../../../../core/widgets/common_widget/custom_text_field.dart';
import '../../../../core/widgets/normal_widget/oval_image.dart';

class RegisterScreen extends StatefulWidget {
  static const route = 'RegisterScreen';

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _phoneOrEmailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _authMethodController = TextEditingController();

  final role = AppState.currentRole;
  bool? _isPhone = true;
  String _gender = "Chọn giới tính";
  String _loginMethod = "Số điện thoại";

  @override
  void initState() {
    super.initState();
    _authMethodController.text = _loginMethod;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: kBackgroundColor,
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(kBorderRadiusMd)),
      ),
      child: ClipRRect(
        borderRadius:
            const BorderRadius.vertical(top: Radius.circular(kBorderRadiusMd)),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  OvalImage(
                      imagePath: role == 'Phụ huynh'
                          ? 'assets/images/parent_teach.jpg'
                          : 'assets/images/class.jpg'),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kPaddingXl),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: kMarginXl),
                        Text(
                          "Đăng ký",
                          style: AppTextStyle.bold(kTextSizeXxl),
                        ),
                        Text(
                          "Tạo một tài khoản ${role.toLowerCase()}",
                          style: AppTextStyle.semibold(kTextSizeMd, kGreyColor),
                        ),
                        const SizedBox(height: kMarginXl),
                        CustomTextField(
                          controller: _genderController,
                          text: role == 'Phụ huynh' ? 'Cha/Mẹ' : 'Thầy/Cô',
                          options: role == 'Phụ huynh'
                              ? ["Cha", "Mẹ"]
                              : ["Thầy", "Cô"],
                          height: 60.0,
                          onChanged: (selectedGender) {
                            setState(() {
                              _gender = selectedGender;
                              _genderController.text = _gender;
                            });
                          },
                        ),
                        const SizedBox(height: kMarginMd),
                        CustomTextField(
                            controller: _nameController,
                            text: "Họ và tên",
                            height: 60.0),
                        const SizedBox(height: kMarginMd),
                        CustomTextField(
                          controller: _authMethodController,
                          text: 'Phương thức đăng nhập',
                          options: ["Số điện thoại", "Email"],
                          height: 60.0,
                          defaultValue: "Số điện thoại",
                          onChanged: (selectedLoginMethod) {
                            setState(() {
                              _loginMethod = selectedLoginMethod;
                              _authMethodController.text = _loginMethod;
                              if (selectedLoginMethod == 'Số điện thoại') {
                                _isPhone = true;
                              } else {
                                _isPhone = false;
                              }
                            });
                          },
                        ),
                        const SizedBox(height: kMarginMd),
                        CustomTextField(
                          controller: _phoneOrEmailController,
                          text: _isPhone == true ? "Số điện thoại" : "Email",
                          isNumber: _isPhone ?? true,
                          height: 60.0,
                        ),
                        const SizedBox(height: kMarginMd),
                        CustomTextField(
                            controller: _passwordController,
                            text: "Mật khẩu",
                            isPassword: true,
                            height: 60.0),
                        const SizedBox(height: kMarginMd),
                        CustomTextField(
                            controller: _confirmPasswordController,
                            text: "Nhập lại mật khẩu",
                            isPassword: true,
                            height: 60.0),
                        const SizedBox(height: kMarginLg),
                        Text(
                          "Mật khẩu phải bao gồm ít nhất 8 ký tự, bao gồm chữ và số",
                          style: AppTextStyle.medium(kTextSizeSm),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: kMarginLg),
                        const CustomButton(
                          text: 'Tạo',
                          isDisabled: false,
                        ),
                        const SizedBox(height: kMarginLg),
                        Text.rich(
                          TextSpan(
                            text: "khi bạn đăng ký, bạn đồng ý với ",
                            style: AppTextStyle.medium(kTextSizeSm),
                            children: [
                              TextSpan(
                                text: "Điều khoản sử dụng",
                                style: AppTextStyle.medium(kTextSizeSm)
                                    .copyWith(color: Colors.blue),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    print("Điều khoản sử dụng clicked");
                                  },
                              ),
                              TextSpan(
                                text: " và ",
                                style: AppTextStyle.medium(kTextSizeSm),
                              ),
                              TextSpan(
                                text: "Chính sách bảo mật",
                                style: AppTextStyle.medium(kTextSizeSm)
                                    .copyWith(color: Colors.blue),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    print("Chính sách bảo mật clicked");
                                  },
                              ),
                              TextSpan(
                                text: " của ClassPal.",
                                style: AppTextStyle.medium(kTextSizeSm),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: kMarginXl),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              " Bạn đã có tài khoản?",
                              style: AppTextStyle.semibold(
                                  kTextSizeMd, kGreyColor.withOpacity(0.5)),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Text(
                                "Đăng nhập",
                                style: AppTextStyle.semibold(
                                    kTextSizeMd, kGreyColor),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: kMarginXxl),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(kPaddingLg),
              child: Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Iconsax.close_circle),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
