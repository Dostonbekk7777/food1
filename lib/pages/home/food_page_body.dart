import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:untitled/controllers/popular_product_controller.dart';
import 'package:untitled/controllers/recommended_product_controller.dart';
import 'package:untitled/main.dart';
import 'package:untitled/models/products_model.dart';
import 'package:untitled/pages/popular_food_detail.dart';
import 'package:untitled/routes/route_helper.dart';
import 'package:untitled/utils/app_constants.dart';
import 'package:untitled/utils/dimensions.dart';
import 'package:untitled/widgets/app_column.dart';
import 'package:untitled/widgets/big_text.dart';
import 'package:untitled/widgets/icon_and_text_widget.dart';
import 'package:untitled/widgets/small_text.dart';

import '../../utils/colors.dart';

class FoodPageBody extends StatefulWidget {
  FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = Dimensions.pageViewContainer;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(

        children: [
          // slider section
      GetBuilder<PopularProductController>(builder:(popularProducts){
        return popularProducts.isLoaded?Container(
          height: Dimensions.pageView,
            child: PageView.builder(
                controller: pageController,
                itemCount: popularProducts.popularProductList.length,
                itemBuilder: (context, position) {
                  return _buildPageItem(position, popularProducts.popularProductList[position]);
                }),
        ):
        Container(
          padding: EdgeInsets.all(Dimensions.radius30),
          height: Dimensions.popularFoodImgSize,
            width: Dimensions.popularFoodImgSize,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius30 *2),
              color: Colors.indigo.shade500
            ),
            child: CircularProgressIndicator(color: Colors.white,));
      }),
      // slider Dots
      GetBuilder<PopularProductController>(builder: (popularProducts){
        return DotsIndicator(
          dotsCount: popularProducts.popularProductList.isEmpty?1:popularProducts.popularProductList.length,
          position: _currPageValue,
          decorator: DotsDecorator(
            activeColor: AppColors.mainColor,
            size: const Size.square(9.0),
            activeSize: const Size(18.0, 9.0),
            activeShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          ),
        );
      }),
      SizedBox(
        height: Dimensions.height30,
      ),
      Container(
        margin: EdgeInsets.only(
          left: Dimensions.width30,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [

            // recommended
            BigText(text: 'Menu'),
            SizedBox(
              width: Dimensions.width10,
            ),
            Container(
              margin: EdgeInsets.only(bottom: 2),
              child: BigText(
                text: '.',
                color: Colors.black45,
              ),
            ),
            SizedBox(
              width: Dimensions.width10,
            ),
            Container(
              child: SmallText(
                text: 'Qo`shimchalar',
              ),
            )
          ],
        ),
      ),
      // recommended list
      // list of food and images
    GetBuilder<RecommendedProductController>(builder: (recommendedProduct){
      return recommendedProduct.isLoaded? ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: recommendedProduct.recommendedProductList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: (){
                Get.toNamed(RouteHelper.getRecommendedFood(index,"home"));
              },
              child: Container(
                margin: EdgeInsets.only(
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                    bottom: Dimensions.height10),
                child: Row(
                  children: [
// image section
                    Container(
                      height: Dimensions.listViewImgSize,
                      width: Dimensions.listViewImgSize,
                      decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(Dimensions.radius20),
                          color: Colors.green.withOpacity(.3),
                          image: DecorationImage(
                              image: NetworkImage(AppConstants.BASE_URL+"/uploads/"+recommendedProduct.recommendedProductList[index].img!),
                              fit: BoxFit.cover)),
                    ),
// text sections
                    Expanded(
                      child: Container(
                        height: Dimensions.listViewTextSize,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(Dimensions.radius20),
                                bottomRight:
                                Radius.circular(Dimensions.radius20)),
                            color: AppColors.mainColor.withOpacity(0.07) ),
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: Dimensions.width10,
                              right: Dimensions.width10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              BigText(
                                text: recommendedProduct.recommendedProductList[index].name!,
                              ),
                              SizedBox(
                                height: Dimensions.height10,
                              ),
                              SmallText(
                                text: 'Ajoyib masallig`lar bilan tayyorlangan',
                                color: AppColors.mainBlackColor,
                              ),
                              SizedBox(
                                height: Dimensions.height10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  IconAndTextWidget(
                                      icon: Icons.circle,
                                      text: "Normal",
                                      iconColor: AppColors.iconColor1),
                                  IconAndTextWidget(
                                      icon: Icons.location_on,
                                      text: "1.7 km",
                                      iconColor: AppColors.mainColor),
                                  IconAndTextWidget(
                                      icon: Icons.access_time_rounded,
                                      text: "32 min",
                                      iconColor: AppColors.iconColor1),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }):
      Container(
          padding: EdgeInsets.all(Dimensions.radius30),
          height: Dimensions.listViewImgSize,
          width: Dimensions.listViewImgSize,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius30 *2),
              color: AppColors.mainColor
          ),
          child: CircularProgressIndicator(color: Colors.white,));
    }) ,
    ]);
  }

  Widget _buildPageItem(int index, ProductModel popularProduct) {
    Matrix4 matrix = new Matrix4.identity();
    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
    }
    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
          onTap: (){
    Get.toNamed(RouteHelper.getPopularFood(index,"home" ));
    },
            child: Container(
              height: Dimensions.pageViewContainer,
              margin: EdgeInsets.only(
                  left: Dimensions.width10, right: Dimensions.width10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                color: index.isEven ? Color(0xFF69c5df) : Color(0xFF9294cc),
                image: DecorationImage(
                    image: NetworkImage(
                     AppConstants.BASE_URL+"/uploads/"+popularProduct.img!
                    ),
                    fit: BoxFit.cover),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                height: Dimensions.pageViewTextContainer,
                margin: EdgeInsets.only(
                    left: Dimensions.width30,
                    right: Dimensions.width30,
                    bottom: Dimensions.height30),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xFFe8e8e8),
                          blurRadius: 5.0,
                          offset: Offset(0, 10)),
                      BoxShadow(
                          color: Colors.white,
                          //blurRadius: 5.0,
                          offset: Offset(-5, 0)),
                      BoxShadow(
                          color: Colors.white,
                          //blurRadius: 5.0,
                          offset: Offset(5, 0))
                    ]),
                child: Container(
                  padding: EdgeInsets.only(
                      top: Dimensions.height15, left: 15, right: 15),
                  child: AppColumn(
                    text: popularProduct.name!,
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
