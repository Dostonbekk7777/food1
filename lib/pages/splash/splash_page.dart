import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:untitled/routes/route_helper.dart';
import 'package:untitled/utils/dimensions.dart';

import '../../controllers/popular_product_controller.dart';
import '../../controllers/recommended_product_controller.dart';
import '../../utils/colors.dart';

class SplashPage extends StatefulWidget {
  static final String id = 'splash_page';
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin{

  late Animation<double> animation;
late AnimationController controller;

 Future<void> _loadResoursce()async{
     await Get.find<PopularProductController>().getPopularProductList();
     await  Get.find<RecommendedProductController>().getRecommendedProductList();
  }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadResoursce();
    controller = new AnimationController(
        vsync: this,
        duration: Duration(seconds: 2))..forward();
    animation = CurvedAnimation(parent: controller,
        curve: Curves.linearToEaseOut,
    );
    Timer(Duration(seconds: 3),()=> Get.offNamed(RouteHelper.getInitial()));
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color:AppColors.mainColor.withOpacity(0.8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: animation,
              child: Container(
                height: Dimensions.splashImage,
                width: Dimensions.splashImage,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/teapot-modified.png'),)
                ),
              ),
            ),
            
          ],),
      ),
    );
  }
}