import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vms_visitor_flutter/app/data/constants.dart';
import 'package:vms_visitor_flutter/app/modules/auth/controllers/auth_controller.dart';
import 'package:vms_visitor_flutter/app/routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kLightBlue,
        elevation: 0,
        actions: [
          TextButton.icon(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Get.find<AuthController>().signOut();
            },
            label: const Text(
              "Logout",
              style: TextStyle(color: kWhite),
            ),
          )
        ],
        centerTitle: true,
      ),
      body: InkWell(
        onTap: () => Get.toNamed(Routes.VISITOR_DETAILS),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: Image.asset('assets/icons/vms_logo.png'),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Visitor app",
                style: Get.textTheme.headline4,
              ),
              const SizedBox(
                height: 150,
              ),
              Obx(
                () => Text(
                  controller.companyName.value ?? 'No company name',
                  style: Get.textTheme.headline5,
                ),
              ),
              const SizedBox(height: 50),
              Text(
                "TOUCH TO START",
                style: Get.textTheme.headline6?.copyWith(color: kWhite),
              )
            ],
          ),
        ),
      ),
    );
  }
}
