import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tsavaari/features/menu/models/menu_content_model.dart';
import 'package:tsavaari/utils/exceptions/format_exceptions.dart';
import 'package:tsavaari/utils/exceptions/platform_exceptions.dart';
import 'package:http/http.dart' as http;

class MenuRepository extends GetxController {
  static MenuRepository get instance => Get.find();

  //Get all the notifications
  Future<MenuContentModel> getMenuContent() async {
    try {
      final response = await http.get(Uri.parse("https://tappadmin-stage.tsavaari.com/contents"));
      if (response.statusCode == 200) {
        return MenuContentModel.fromJson(json.decode(response.body));
      } else {
        throw Exception("Failed to load content");
      }
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      print(e.toString());
      throw 'Something went wrong. Please try again later!';
    }
  }
  
}
