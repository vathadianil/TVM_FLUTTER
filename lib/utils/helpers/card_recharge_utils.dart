import 'dart:math';
import 'package:crypto/crypto.dart';
import 'dart:convert';

import 'package:intl/intl.dart';

class CardRechargeUtils {
  // static String plainCredentials = "HYDMetroMobileApp:MobileApp@HydMetro1234";
  // static String bankCode = "05";
  // static String topUpChannel = "08";
  static String plainCredentials = "JIO:LtMetroJIO0312";
  static String bankCode = "03";
  static String topUpChannel = "12";
  // static String cardValidationDecryptString = "dFNhdmFhciFhZmNzYWx0";
  // static String decryptAesKey = "000102030405060708090a0b0c0d0e0f";

  static String getBankRequestDateTime() {
    final now = DateTime.now();
    final formattedDateTime = "${now.year.toString().padLeft(4, '0')}"
        "${now.month.toString().padLeft(2, '0')}"
        "${now.day.toString().padLeft(2, '0')}"
        "${now.hour.toString().padLeft(2, '0')}"
        "${now.minute.toString().padLeft(2, '0')}"
        "${now.second.toString().padLeft(2, '0')}";
    return formattedDateTime;
  }

  static String getBankRequestDateTimeForValidation() {
    final now = DateTime.now();
    final dateTimeString = DateFormat('yyyyMMddhhmm').format(now);
    final result = "${dateTimeString}00";
    return result;
  }

  static String getBankReferenceNumber(
      String cardNumber, String bankRequestDateTime) {
    final backRef = bankRequestDateTime + generateRandomNumber(6);
    return backRef;
  }

  static String generateRandomNumber(int charLength) {
    if (charLength < 1) return '0';

    final random = Random();
    final min = pow(10, charLength - 1).toInt();
    final max = pow(10, charLength).toInt() - 1;

    return (min + random.nextInt(max - min + 1)).toString();
  }

  static String getHash(String cardNumber, String bankRefNumberOrBankCode) {
    final base = (cardNumber + bankRefNumberOrBankCode).trim();

    // Convert the string to bytes (UTF-8)
    final bytes = utf8.encode(base);

    // Compute the SHA-256 hash
    final digest = sha256.convert(bytes);

    // Convert the hash to a hexadecimal string
    return digest.toString();
  }

  // String getDecryptedString(String value, String hash) {
  //   try {
  //     // Decode the Base64-encoded value
  //     List<int> decodedBytes = base64Decode(value);
  //     // Convert the decoded bytes to a UTF-8 string
  //     String decrypted = utf8.decode(decodedBytes);
  //     return decrypted;
  //   } catch (e) {
  //     return "crypto error";
  //   }
  // }

  static String getDecryptedString(String value, String hash) {
    try {
      // Decode the Base64-encoded string
      final decodedBytes = base64Decode(value);
      final decrypted = utf8.decode(decodedBytes);

      return decrypted;
    } catch (e) {
      throw ("Error during decryption: $e");
    }
  }
}
