import 'package:flutter/cupertino.dart';

import '../widgets/textbuider.dart';
import 'appcolor.dart';

class AppNameWidget extends StatelessWidget {
  const AppNameWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextBuilder(text: 'SUPER ', color: AppColors.kBlue, fontSize: 20, fontWeight: FontWeight.w700),
        TextBuilder(text: 'STORE', color: AppColors.kGreen, fontSize: 20),
      ],
    );
  }
}
