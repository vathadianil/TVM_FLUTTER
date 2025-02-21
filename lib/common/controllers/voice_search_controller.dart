import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class VoiceSearchController extends GetxController {
  final SpeechToText speechToText = SpeechToText();
  final _speechEnabled = false.obs;
  final stationEditingController = TextEditingController();
  final recHintText = ''.obs;

  // @override
  // onInit() {
  //   super.onInit();
  //   _initSpeech();
  // }

  _initSpeech() async {
    _speechEnabled.value = await speechToText.initialize();
  }

  void startListening() async {
    if (_speechEnabled.value) {
      await speechToText.listen(onResult: _onSpeechResult);
      recHintText.value = speechToText.isListening ? 'Listening' : 'Tap';
    } else {
      await _initSpeech();
      await speechToText.listen(onResult: _onSpeechResult);
      recHintText.value = speechToText.isListening ? 'Listening' : 'Tap';
    }
  }

  void stopListening() async {
    await speechToText.stop();
    recHintText.value = speechToText.isListening ? 'Listening' : 'Tap';
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    final wordsSpoken = result.recognizedWords;
    if (wordsSpoken != '') {
      stationEditingController.text = wordsSpoken;
      stopListening();
    }
  }
}
