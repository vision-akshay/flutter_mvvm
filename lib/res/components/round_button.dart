import 'package:flutter/material.dart';
import 'package:flutter_mvvm/res/app_colors.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final bool loading;
  final VoidCallback onPress;
  const RoundButton({
    Key? key,
    required this.title,
    this.loading = false,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: 40,
        width: 200,
        decoration: const BoxDecoration(
          color: AppColor.buttonColor,
        ), // BoxDecoration
        child: Center(
            child: loading ? const CircularProgressIndicator() :  Text(title)),
      ), // Container
    );
  }
}
