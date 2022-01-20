import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';

showSnackBar({
  String? title,
  String? message,
  Color? backgroundColor,
  Color? foregroundColor,
}) {
  Get.snackbar(
    title ?? '',
    message ?? '',
    snackPosition: SnackPosition.BOTTOM,
    margin: const EdgeInsets.all(20),
    backgroundColor: backgroundColor,
    colorText: foregroundColor,
  );
}

const String testUrl = "https://api-vms.herokuapp.com";
const String apiUrl = testUrl;

Dio dioClient = Dio();
