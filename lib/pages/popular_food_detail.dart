import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:untitled/pages/cart/cart_page.dart';
import 'package:untitled/pages/home/main_food_page.dart';
import 'package:untitled/utils/app_constants.dart';
import 'package:untitled/utils/dimensions.dart';
import 'package:untitled/widgets/app_column.dart';
import 'package:untitled/widgets/expandable_text_widget.dart';

import '../controllers/cart_controller.dart';
import '../controllers/popular_product_controller.dart';
import '../routes/route_helper.dart';
import '../utils/colors.dart';
import '../widgets/app_icon.dart';
import '../widgets/big_text.dart';
import '../widgets/icon_and_text_widget.dart';
import '../widgets/small_text.dart';

class PopularFoodDetail extends StatelessWidget {
  int pageId;
  final String page;
  PopularFoodDetail({Key? key,required this.pageId, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product=Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>().initProduct(product,Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // backGrounqdImage
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: Dimensions.popularFoodImgSize,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image:NetworkImage(
                    AppConstants.BASE_URL+"/uploads/"+product.img!
                  )
                )
              ),
            ),
          ),

          //icon widget
          Positioned(
            top: Dimensions.height45,
            left:Dimensions.width20,
            right:Dimensions.height20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap:(){
                   if(page=="cartpage"){
                     Get.toNamed(RouteHelper.getCartPage());
                   }else{
                     Navigator.pop(context);
                   }
                   ;
                  },
                  child: AppIcon(icon: Icons.clear,
                  iconColor: AppColors.mainBlackColor,),
                ),
              GetBuilder<PopularProductController>(builder: (controller){
                return Stack(
                  children: [
                    GestureDetector(
                    onTap:(){
                      if(controller.totalItems>=1)
                      Get.toNamed(RouteHelper.getCartPage());
                },
                      child: AppIcon(
                        icon: Icons.shopping_cart_outlined,
                        iconColor:Colors.black,
                      ),
                    ),
                    Get.find<PopularProductController>().totalItems>=1? Positioned(
                      bottom:0,
                      right:0,
                        child: AppIcon(
                icon: Icons.circle,size: 20,
                iconColor:Colors.transparent,
                          backgroundColor: AppColors.mainColor,
                ),
                    ):Container(),
                    Get.find<PopularProductController>().totalItems>=1?
                    Positioned(
                      bottom:3,
                      right:6,
                      child: BigText(text:Get.find<PopularProductController>().totalItems.toString(),
                      size: 12,
                      color: Colors.white,)
                    ):Container()
                  ],
                );
              },),
              ],
            ),
          ),

          // introduction(tavsif)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: Dimensions.popularFoodImgSize-Dimensions.height20,
            child:Container(
              padding: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20, top: Dimensions.height20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: Colors.white
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppColumn(text:product.name!,),
                  SizedBox(height: Dimensions.height20,),
                  BigText(text: 'Tavsif'),
                  SizedBox(height: Dimensions.height20,),
                Expanded(child: SingleChildScrollView(child:
                ExpandableTextWidget(text: product.description!),
                ),
                )
                ],
              )

            )
          )

          // expandable text widget

        ],
      ),
      // cart bottom
      bottomNavigationBar:  GetBuilder<PopularProductController>(builder: (popularProduct){
        return Container(
          height: Dimensions.bottomHeightBar*1.21,
          padding: EdgeInsets.only(top: Dimensions.height30,bottom:Dimensions.height30, left: Dimensions.width20,right: Dimensions.width20),
          decoration:BoxDecoration(
              color: AppColors.buttonBackGroundColor,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(Dimensions.radius20 * 2),topRight: Radius.circular(Dimensions.radius20*2))
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(top: Dimensions.height20,bottom: Dimensions.height20,left: Dimensions.width20, right: Dimensions.width20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap:(){
                        popularProduct.setQuantity(false);
                      },
                        child: Icon(Icons.remove,color: AppColors.mainBlackColor,)),
                    SizedBox(width: Dimensions.width15,),
                    BigText(text: popularProduct.inCartItems.toString()),
                    SizedBox(width: Dimensions.width15,),
                    GestureDetector(
                        onTap: (){
                          popularProduct.setQuantity(true);
                        },
                        child: Icon(Icons.add, color: AppColors.mainBlackColor,))],
                ),
              ),
              GestureDetector(
                onTap: (){
                  popularProduct.addItem(product);
                },
                child: Container(
                  padding: EdgeInsets.only(top: Dimensions.height20,bottom: Dimensions.height20,left: Dimensions.width10, right: Dimensions.width10),
                  child:  BigText(text: '\$ ${product.price!} | Savatga qo`shish',color: Colors.white,size: 18,),
                  decoration:BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: AppColors.mainColor
                  ),
                ),
              )
            ],
          ),
        );
      },)
    );
  }
}
