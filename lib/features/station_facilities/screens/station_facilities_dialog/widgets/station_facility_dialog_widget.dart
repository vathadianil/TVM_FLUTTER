// custom_dialog.dart
import 'package:flutter/material.dart';
import 'package:tsavaari/utils/constants/size_config.dart';

class StationFacilityDialogWidget extends StatelessWidget {
  final String icon;
  final String title;
  final String content;

  const StationFacilityDialogWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              icon,
              height: SizeConfig.blockSizeHorizontal * 18, 
            ),
            SizedBox(height: SizeConfig.blockSizeVertical * 1.5),
            Text(
              title,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: SizeConfig.blockSizeVertical * 2),

            Text(
              content,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
