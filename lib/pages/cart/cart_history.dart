

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:untitled/utils/app_constants.dart';
import 'package:untitled/utils/colors.dart';
import 'package:untitled/utils/dimensions.dart';
import 'package:untitled/widgets/app_icon.dart';
import 'package:untitled/widgets/big_text.dart';
import 'package:untitled/widgets/small_text.dart';

import '../../controllers/cart_controller.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

  var  getCartHistoryList = Get.find<CartController>()
      .getCartHistoryList().reversed.toList();

    Map<String, int> cartItemsPerOrder  = Map();

    for(int i = 0; i< getCartHistoryList.length;i++){
      if(cartItemsPerOrder.containsKey(getCartHistoryList[i].time)){
        cartItemsPerOrder.update(getCartHistoryList[i].time!, (value) => ++value);
      }else{
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () =>1);
      }
      print(cartItemsPerOrder);

    }

    List<int> cartOrderTimeToList(){
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }
    List<int> itemsPerOrder = cartOrderTimeToList();
    var listCounter = 0;
    return Scaffold(
        body:Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: Dimensions.height45),
            width: double.maxFinite,
            height: Dimensions.height10*10,
            color: AppColors.mainColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BigText(text: "Savatingiz tarixi",color: Colors.white,),
                AppIcon(icon: Icons.shopping_cart_outlined,backgroundColor: AppColors.mainColor,iconColor: Colors.white,),

              ],
            ),
          ),
         Expanded(child: Container(

         margin: EdgeInsets.only(top: Dimensions.height20,left: Dimensions.width20, right: Dimensions.width20),
    child: MediaQuery.removePadding(
      removeTop:true,
      context: context, child: ListView(
      children: [
        for(int i = 0; i< cartItemsPerOrder.length;i++)
          Container(
            height: 120,
            margin:EdgeInsets.only(bottom: Dimensions.height20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ((){
                DateTime parseDate =  DateFormat("yyyy-MM-dd HH:mm:ss").parse(getCartHistoryList[listCounter].time!);
                var inputDate = DateTime.parse(parseDate.toString());
                 var outputFormat =  DateFormat("MM/dd/yyyy hh:mm a");
                var outputDate = outputFormat.format(inputDate);
                  return BigText(text: outputDate,);
    }()),
                SizedBox(height: Dimensions.height10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Wrap(
                    direction: Axis.horizontal,
                    children: List.generate(itemsPerOrder[i], (index){
                      if(listCounter<getCartHistoryList.length){
                        listCounter++;
                      }
                      return index<=2?Container(
                        margin: EdgeInsets.only(left: Dimensions.width10/2),
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.radius20),

                            image: DecorationImage(fit: BoxFit.cover,image: NetworkImage(AppConstants.BASE_URL+"/uploads/"+getCartHistoryList[listCounter-1].img!))
                        ),
                      ):Container();
                    }),
                  ),
                  Container(
                    height: 80,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SmallText(text: "Total",color: AppColors.mainBlackColor,),
                          BigText(text: itemsPerOrder[i].toString()+" Ta",color: AppColors.titleColor,),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: Dimensions.width10, vertical: Dimensions.height10/2),
                            decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.radius20/2),
                            border: Border.all(width: 1,color: AppColors.mainColor)
                          ),
                          child: SmallText(text: "qo`shish",color: AppColors.mainColor,),)
                        ],
                      ),
                  )
                ],)
              ],
            ),
          )
      ],
    ),)
    ),)

        ],
      )
    );
  }
}
