import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:untitled/pages/recommended_food_detail.dart';
import 'package:untitled/utils/dimensions.dart';
import 'package:untitled/widgets/big_text.dart';
import 'package:untitled/widgets/small_text.dart';

import '../../utils/colors.dart';
import 'food_page_body.dart';
class MainFoodPage extends StatefulWidget {
  static final String id = 'main_food_page';

  const MainFoodPage({Key? key}) : super(key: key);

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(

        children: [
          // header
          Container(
            child: Container(
              margin: EdgeInsets.only(top: Dimensions.height45, bottom: Dimensions.height15),
              padding: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      BigText(text: 'Tashkent',color: AppColors.mainColor,),
                      Row(
                        children: [
                          SmallText(text: 'bo`yicha',color: Colors.grey,),
                          Icon(Icons.arrow_drop_down_rounded)
                        ],
                      )
                    ],
                  ),
                  Center(
                    child: Container(
                      height: Dimensions.height45,
                      width: Dimensions.height45,
                      child: Icon(Icons.search, color: Colors.white,size: Dimensions.iconSize24,),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radius15),
                          color: AppColors.mainColor
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          // body
         Expanded(child: SingleChildScrollView(
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Padding(
                 padding:  EdgeInsets.only(left: Dimensions.width30),
                 child: BigText(text: 'Mashhurlari'),
               ),
               SizedBox(height: Dimensions.height20,),
               FoodPageBody(),
             ],
           ),
         ))
        ],
      ),
    );
  }
}
