import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/portfolio_controller.dart';
import 'views/portfolio_view.dart';

void main() {

  Get.put(PortfolioController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final PortfolioController controller = Get.find();

    return Obx(() => GetMaterialApp(
      title: 'Developer Portfolio',
      debugShowCheckedModeBanner: false,
      theme: controller.isDarkTheme.value ? ThemeData.dark() : ThemeData.light(),
      home: const PortfolioView(),
    ));
  }
}
