import 'package:flutter/material.dart';
import 'package:flutter_class_pal/core/widgets/common_widget/custom_list_item.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/constants/constant.dart';
import '../../../../core/utils/app_text_style.dart';
import '../../../../core/widgets/common_widget/custom_text_field.dart';
import '../../model/score_type_model.dart';
import '../../model/subject_model.dart';
import 'class_score_screen.dart';

class ClassScoreSubjectScreen extends StatefulWidget {
  final SubjectModel subject;

  const ClassScoreSubjectScreen({super.key, required this.subject});

  @override
  State<ClassScoreSubjectScreen> createState() =>
      _ClassScoreSubjectScreenState();
}

class _ClassScoreSubjectScreenState extends State<ClassScoreSubjectScreen> {
  TextEditingController _selectedScoreTypeController = TextEditingController();
  String? selectedScoreType;

  @override
  void initState() {
    super.initState();
    // Set the selected score type to the first type in the list by default
    selectedScoreType = widget.subject.scores.isNotEmpty
        ? widget.subject.scores.first.scoreTypes.first.typeName
        : null;
    _selectedScoreTypeController.text = selectedScoreType ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final scoreTypes = widget.subject.scores
        .expand((score) => score.scoreTypes.map((type) => type.typeName))
        .toSet()
        .toList();

    return Container(
      padding: const EdgeInsets.only(left: kPaddingLg, right: kPaddingLg, top: kPaddingLg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(kBorderRadiusMd)),
        border: Border.all(color: Colors.grey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  child: const FaIcon(FontAwesomeIcons.arrowLeft),
                  onTap: () {
                    Navigator.pop(context);
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) {
                        return FractionallySizedBox(
                          alignment: Alignment.bottomCenter,
                          heightFactor: 0.95,
                          child: ClassScoreScreen(),
                        );
                      },
                    );
                  },
                ),
              ),
              Center(
                child: Text(
                  widget.subject.name,
                  style: AppTextStyle.bold(kTextSizeLg),
                ),
              ),
            ],
          ),
          const SizedBox(height: kMarginLg),
          CustomTextField(
            autofocus: true,
            text: 'Vui lòng chọn loại điểm',
            controller: _selectedScoreTypeController,
            onChanged: (value) {
              setState(() {
                selectedScoreType = value;
              });
            },
            options: scoreTypes,
          ),
          const SizedBox(height: kMarginMd),
          if (widget.subject.scores.isEmpty)
            const Expanded(child: Center(child: Text('Không có dữ liệu điểm')))
          else
            Expanded(
              child: ListView(
                children: widget.subject.scores.map((score) {
                  final selectedScore = score.scoreTypes.firstWhere(
                        (type) => type.typeName == selectedScoreType,
                    orElse: () =>
                    const ScoreTypeModel(typeName: '', score: '0.0', note: ''),
                  );
                  return CustomListItem(
                    title: score.studentName,
                    subtitle: '${selectedScore.score}',

                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }
}
