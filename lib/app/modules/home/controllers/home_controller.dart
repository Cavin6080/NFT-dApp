import 'dart:developer';

import 'package:alan_voice/alan_voice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nft/contract_linking.dart';

class HomeController extends GetxController {
  ContractLinking contractLinking;
  late final TextEditingController controller;

  HomeController(this.contractLinking);

  RxList<String> quotes = <String>[].obs;
  // RxList<String> quotes = <String>[
  //   "First, solve the problem. Then, write the code. - John Johnson",
  //   "Experience is the name everyone gives to their mistakes – Oscar Wilde",
  //   "In order to be irreplaceable, one must always be different - Coco Chanel",
  //   "Java is to Javascript what car is to Carpet - Chris Heilmann",
  //   "Code is like humor. When you have to explain it, it’s bad - Cory House",
  //   "Java is to Javascript what car is to Carpet - Chris Heilmann",
  //   "Fix the cause, not the symptom - Steve Maguire",
  //   "First, solve the problem. Then, write the code. - John Johnson",
  //   "Experience is the name everyone gives to their mistakes – Oscar Wilde",
  //   "In order to be irreplaceable, one must always be different - Coco Chanel",
  //   "Java is to Javascript what car is to Carpet - Chris Heilmann",
  //   "Code is like humor. When you have to explain it, it’s bad - Cory House",
  //   "Java is to Javascript what car is to Carpet - Chris Heilmann",
  //   "Fix the cause, not the symptom - Steve Maguire",
  //   "First, solve the problem. Then, write the code. - John Johnson",
  //   "Experience is the name everyone gives to their mistakes – Oscar Wilde",
  //   "In order to be irreplaceable, one must always be different - Coco Chanel",
  //   "Java is to Javascript what car is to Carpet - Chris Heilmann",
  //   "Code is like humor. When you have to explain it, it’s bad - Cory House",
  //   "Java is to Javascript what car is to Carpet - Chris Heilmann",
  //   "Fix the cause, not the symptom - Steve Maguire",
  // ].obs;
  final registerFormKey = GlobalKey<FormState>();
  bool isLoading = true;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onInit() {
    controller = TextEditingController();
    getNFTS();
    super.onInit();
  }

  getNFTS() async {
    await Future.delayed(const Duration(seconds: 5));
    quotes.value = await contractLinking.getURIs();
    quotes.refresh();
    isLoading = false;
    update();
    // AlanVoice.addButton(
    //   "99b3f541de1a702448cb65a189de34ea2e956eca572e1d8b807a3e2338fdd0dc/stage",
    //   buttonAlign: AlanVoice.BUTTON_ALIGN_RIGHT,
    // );

    // /// Handle commands from Alan Studio
    // AlanVoice.onCommand.add((command) {
    //   log("got new command ${command.toString()}");
    // });
  }

  void onTap() async {
    if (registerFormKey.currentState!.validate()) {
      quotes.value = await contractLinking.createTokenURIs(controller.text);
      quotes.refresh();
      update();
      Get.back();
      controller.clear();
    }
  }
}
