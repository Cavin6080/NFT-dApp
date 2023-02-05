import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nft/app/routes/app_pages.dart';
import 'package:nft/contract_linking.dart';
import 'package:nft/logic.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      initialRoute: Routes.ONBOARDING,
      getPages: AppPages.routes,
    );
  }
}
