import 'package:ared/core/utils/echo.dart';
import 'package:ared/modules/layout/provider/layout_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/view/widgets/status_bar.dart';
import '../../../../modules/layout/view/components/home_bnb.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  late final LayoutProvider layoutProvider;

  @override
  void initState() {
    kEcho('initState');
    layoutProvider = Provider.of<LayoutProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      layoutProvider.setCurrentIndex(0);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StatusBar(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            PageView.builder(
              controller: layoutProvider.pageController,
              itemCount: layoutProvider.screens.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => Consumer<LayoutProvider>(builder: (context, value, child) {
                return layoutProvider.screens[value.currentScreenIndex];
              },),
            ),
            HomeBNB(layoutProvider),
          ],
        ),
      ),
    );
  }
}
