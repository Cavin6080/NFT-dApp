import 'package:get/get.dart';
import 'package:nft/contract_linking.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(ContractLinking()),
    );
  }
}
