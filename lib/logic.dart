import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nft/contract_linking.dart';

class NFTController extends GetxController {
  ContractLinking contractLinking;
  late final TextEditingController controller;

  NFTController(this.contractLinking);

  @override
  void onInit() {
    controller = TextEditingController();
    super.onInit();
  }

  void onTap() async {
    await contractLinking.createTokenURIs(controller.text);
  }
}
