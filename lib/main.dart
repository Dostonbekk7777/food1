import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/controllers/popular_product_controller.dart';
import 'package:untitled/pages/cart/cart_page.dart';
import 'package:untitled/pages/home/food_page_body.dart';
import 'package:untitled/pages/home/main_food_page.dart';
import 'package:untitled/pages/popular_food_detail.dart';
import 'package:untitled/pages/recommended_food_detail.dart';
import 'package:untitled/pages/splash/splash_page.dart';
import 'package:untitled/routes/route_helper.dart';
import 'controllers/cart_controller.dart';
import 'controllers/recommended_product_controller.dart';
import 'helper/dependencies.dart' as dep;

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();
    return GetBuilder<PopularProductController>(builder: (_){
     return GetBuilder<RecommendedProductController>(builder: (_){
       return GetMaterialApp(
         debugShowCheckedModeBanner: false,
         title: 'Flutter Demo',
         initialRoute: RouteHelper.getSplash(),
         getPages: RouteHelper.routes,
       );
     });
   });
  }
}