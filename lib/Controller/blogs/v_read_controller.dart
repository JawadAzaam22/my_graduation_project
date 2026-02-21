import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';


class TtsController extends GetxController {
  FlutterTts flutterTts = FlutterTts();
  RxBool click=RxBool(false);
  Future<void> speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.speak(text);
    click.value=true;
    pause=RxBool(false);
  }
  RxBool pause=RxBool(false);

  Future<void> pauseF() async {
    // await flutterTts.stop();
    await flutterTts.pause();
    pause.value=true;
    click.value=false;


  }
  Future<void> stop() async {
    await flutterTts.stop();
    pause.value=true;
    click.value=false;


  }
}
