import 'package:flutter/material.dart';

import '../../../../core/extensions/num_extensions.dart';
import '../../../../core/resources/resources.dart';
import '../../../../core/view/widgets/custom_icon.dart';

class HomeButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;

  const HomeButton({required this.onPressed, required this.icon, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppSize.s40.w,
      height: AppSize.s40.w,
      child: Material(
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(250),
        color: Color(0xffF26060),
        child: InkWell(
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: CustomIcon(icon ),
          ),
        ),
      ),
    );
  }
}
