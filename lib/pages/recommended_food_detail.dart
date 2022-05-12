import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:untitled/controllers/recommended_product_controller.dart';
import 'package:untitled/pages/cart/cart_page.dart';
import 'package:untitled/utils/app_constants.dart';
import 'package:untitled/utils/dimensions.dart';
import 'package:untitled/widgets/app_icon.dart';
import 'package:untitled/widgets/big_text.dart';
import 'package:untitled/widgets/expandable_text_widget.dart';

import '../controllers/cart_controller.dart';
import '../controllers/popular_product_controller.dart';
import '../routes/route_helper.dart';
import '../utils/colors.dart';

class RecommendedFoodDetail extends StatelessWidget {
 final  int pageId;
 String page;
   RecommendedFoodDetail({Key? key,required this.pageId, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product = Get.find<RecommendedProductController>().recommendedProductList[pageId];
    Get.find<PopularProductController>().initProduct(product,Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView (
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                    GestureDetector(
                        onTap:(){
                          if(page=="cartpage"){
                            Get.toNamed(RouteHelper.getCartPage());
                          }else{
                            Get.toNamed(RouteHelper.getInitial());
                          }
                          ;
                        },
                        child: AppIcon(icon: Icons.clear)),
                    //AppIcon(icon: Icons.shopping_cart_outlined)
                GetBuilder<PopularProductController>(builder: (controller){
                  return Stack(
                    children: [
                      GestureDetector(
                        onTap:(){
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
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(35),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(Dimensions.radius30),topRight: Radius.circular(Dimensions.radius30))
                ),
                child: Center(child: BigText(text: product.name!,size: Dimensions.font26,)),
                width: double.maxFinite,
                padding: EdgeInsets.only(top:5, bottom: 10),

              ),

            ),
            pinned:true,
            backgroundColor: Colors.green.shade300,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(AppConstants.BASE_URL+"/uploads/"+product.img!,
                width: double.maxFinite,
                fit: BoxFit.cover,),
            ),
          ),
          SliverToBoxAdapter(

              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20),
                    child:
                    ExpandableTextWidget(text:product.description!
                    ,),
                  )
                ],
              )
          )
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(builder:(controller){
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding:EdgeInsets.only(
                  left: Dimensions.width20 * 2.5,
                  right: Dimensions.width20 * 2.5,
                  top: Dimensions.height10,
                  bottom: Dimensions.height10
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      controller.setQuantity(false);
                    },
                    child: AppIcon(icon: Icons.remove,iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,),
                  ),
                  BigText(text: '\$ ${product.price!}  X  ${controller.inCartItems} ',color: AppColors.mainBlackColor,
                    size: Dimensions.font26,),
                  GestureDetector(
                    onTap: (){
                   controller.setQuantity(true);
                    },
                    child: AppIcon(icon: Icons.add,iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,),
                  )
                ],
              ),
            ),
            Container(
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
                      child:Icon(
                        Icons.favorite,
                        color: AppColors.mainColor,
                      )
                  ),
                  GestureDetector(
                    onTap: (){
                      controller.addItem(product);
                    },
                    child:Container(
                      padding: EdgeInsets.only(top: Dimensions.height20,bottom: Dimensions.height20,left: Dimensions.width10, right: Dimensions.width10),
                      child: BigText(text: '${product.price} | Savatga qo`shish',color: Colors.white,size: 18,),
                      decoration:BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radius20),
                          color: AppColors.mainColor
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      },),
    );
  }
}
