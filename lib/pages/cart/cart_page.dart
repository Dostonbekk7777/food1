import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/controllers/popular_product_controller.dart';
import 'package:untitled/routes/route_helper.dart';
import 'package:untitled/utils/app_constants.dart';
import 'package:untitled/utils/colors.dart';
import 'package:untitled/utils/dimensions.dart';
import 'package:untitled/widgets/big_text.dart';
import 'package:untitled/widgets/small_text.dart';

import '../../controllers/cart_controller.dart';
import '../../controllers/recommended_product_controller.dart';
import '../../widgets/app_icon.dart';
import '../home/main_food_page.dart';
class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body:Stack(
        children: [
          Positioned(
            top: Dimensions.height20*3,
            left:Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap:(){
                  },
                  child: AppIcon(icon:Icons.close,
                  iconColor: Colors.white,
                  backgroundColor: AppColors.mainColor,
                  size:Dimensions.iconSize32*1.2),
                ),
                SizedBox(width: Dimensions.width20*5,),
                GestureDetector(
                  onTap: (){
                    Get.toNamed(RouteHelper.getInitial());
                  },
                  child: AppIcon(icon:Icons.home_outlined,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                      size:Dimensions.iconSize32*1.2),
                ),
                AppIcon(icon:Icons.shopping_cart,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    size:Dimensions.iconSize32*1.2)

              ],

            ),
          ),
          Positioned(
            top: Dimensions.height20*5,
              left: Dimensions.width20,
               right: Dimensions.width20,
              bottom: 0,
              child: Container(
                margin: EdgeInsets.only(top: Dimensions.height15),
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: GetBuilder<CartController>(builder: (cartController){
                    var _cartList = cartController.getItems;
                    return ListView.builder(
                        itemCount: _cartList.length,
                        itemBuilder: (_, index){
                          return Container(

                            width: double.maxFinite,
                            height: Dimensions.height20*5,
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap:(){
                                    var popularIndex = Get.find<PopularProductController>().popularProductList.indexOf(_cartList[index].product);
                                    if(popularIndex>=0){
                                      Get.toNamed(RouteHelper.getPopularFood(popularIndex,"cartpage"));
                                    }else{
                                      var recommendedIndex = Get.find<RecommendedProductController>().recommendedProductList.indexOf(_cartList[index].product);
                                      Get.toNamed(RouteHelper.getRecommendedFood(recommendedIndex,"cartpage"));
                                    }
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(bottom: Dimensions.height10),
                                    width: Dimensions.height20*5,
                                    height: Dimensions.height20*5,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit:BoxFit.cover,
                                            image: NetworkImage(
                                              AppConstants.BASE_URL+"/uploads/"+cartController.getItems[index].img!
                                            )),
                                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                                        color: Colors.white
                                    ),
                                  ),
                                ),
                                SizedBox(width: Dimensions.width10,),
                                Expanded(
                                    child:Container(
                                      height: Dimensions.height20*5,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:CrossAxisAlignment.start,

                                        children: [
                                          BigText(text: cartController.getItems[index].name!),
                                          SmallText(text: "Mazali"),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              BigText(text: cartController.getItems[index].price!.toString(),color: Colors.redAccent,),
                                              Container(
                                                padding: EdgeInsets.only(top: Dimensions.height10,bottom: Dimensions.height10,left: Dimensions.width10, right: Dimensions.width10),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                                                  color: Colors.white,
                                                ),
                                                child: Row(
                                                  children: [
                                                    GestureDetector(
                                                        onTap:(){
                                                          cartController.addItem(_cartList[index].product!, -1);
                                                        },
                                                        child: Icon(Icons.remove,color: AppColors.mainBlackColor,)),
                                                    SizedBox(width: Dimensions.width15,),
                                                    BigText(text:_cartList[index].quantity.toString()), //popularProduct.inCartItems.toString(),),
                                                    SizedBox(width: Dimensions.width15,),
                                                    GestureDetector(
                                                        onTap: (){
                                                          cartController.addItem(_cartList[index].product!, 1);

                                                        },
                                                        child: Icon(Icons.add, color: AppColors.mainBlackColor,))],
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ) )
                              ],
                            ),
                          );
                        });
                  },),
                ),
              ))
        ],
      ),
        bottomNavigationBar:  GetBuilder<CartController>(builder: (cartController){
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

                      SizedBox(width: Dimensions.width15,),
                      BigText(text:"\$ " + cartController.totalAmount.toString()),
                      SizedBox(width: Dimensions.width15,),
                     ],
                  ),
                ),
                GestureDetector(
                  onTap: (){
                   // popularProduct.addItem(product);
                    print("tapped");
                        cartController.addToHistory();
                  },
                  child: Container(
                    padding: EdgeInsets.only(top: Dimensions.height20,bottom: Dimensions.height20,left: Dimensions.width10, right: Dimensions.width10),
                    child:  BigText(text: 'Hisoblash!',color: Colors.white,size: Dimensions.font20 * 1.1,),
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
