import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxnString companyName = RxnString();

  @override
  void onInit() {
    getCompanyName();
    super.onInit();
  }

  void getCompanyName() async {
    const storage = FlutterSecureStorage();
    companyName.value = await storage.read(key: 'companyName');
  }
}
