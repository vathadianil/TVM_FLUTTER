import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tsavaari/utils/constants/colors.dart';

class RechargeStatusCodesModel {
  final String statusInfo;
  final Color? color;
  final IconData? icon;

  RechargeStatusCodesModel({
    required this.statusInfo,
    this.color = TColors.success,
    this.icon = Iconsax.tick_circle,
  });

  factory RechargeStatusCodesModel.fromJson(Map<String, dynamic> json) {
    return RechargeStatusCodesModel(
      statusInfo: json['statusInfo'],
    );
  }
}
