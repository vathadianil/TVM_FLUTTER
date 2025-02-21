import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tsavaari/utils/constants/image_strings.dart';
import 'package:tsavaari/utils/constants/size_config.dart';

class StationLoader extends StatelessWidget {
  const StationLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 20),
      child: Center(
        child: Column(
          children: [
            Lottie.asset(
              TImages.findingStationAnimation,
              height: SizeConfig.blockSizeHorizontal * 50,
              fit: BoxFit.contain,
            ),
            Text(
              'Finding nearest station...',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
