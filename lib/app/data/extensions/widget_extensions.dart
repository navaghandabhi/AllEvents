import 'package:flutter/material.dart';
import 'package:get/get.dart';

extension WidgetExtension on Widget {
  Widget toProgressIndicator(RxBool isLoading) {
    return Obx(()=> isLoading.value ? const Center(child: CircularProgressIndicator()) : this);
  }
}
