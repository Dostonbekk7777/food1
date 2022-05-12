import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/controllers/cart_controller.dart';
import 'package:untitled/data/repository/popular_product_repo.dart';

import '../models/cart_model.dart';
import '../models/products_model.dart';
import '../utils/colors.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;

  PopularProductController({required this.popularProductRepo});

  List<dynamic> _popularProductList = [];

  List<dynamic> get popularProductList => _popularProductList;

  late CartController _cart;

  bool _isLoaded = false;

  bool get isLoaded => _isLoaded;

  int _quantity = 0;
  int get quantity=> _quantity;
  int _inCartItems=0;
  int get inCartItems=>_inCartItems+_quantity;

  CartController get cart => _cart;

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if (response.statusCode == 200) {
      _isLoaded = true;
      _popularProductList = [];
      _popularProductList.addAll(Product
          .fromJson(response.body)
          .products);
      update();
    }
    else {
    }
  }


  void setQuantity(bool isIncrement) {
    if (isIncrement) {

      _quantity = checkQuantity(_quantity + 1);
    } else {
      _quantity = checkQuantity(_quantity - 1);
    }
    update();
  }
  int checkQuantity(int quantity){
    if((_inCartItems+quantity<0)){
      Get.snackbar("Mahsulot soni", "Boshqa kamaytira olmaysiz",
          colorText: Colors.white, backgroundColor: AppColors.mainColor);
      if(_inCartItems>0){
        _quantity = -_inCartItems;
        return _quantity;
      }
      return 0;
    }else if(_inCartItems+quantity>20){
      Get.snackbar("Mahsulot soni", "Boshqa ko`paytira olmaysiz",
      colorText: Colors.white,backgroundColor: AppColors.mainColor);
      return 20;
    }else{
      return quantity;
    }
  }

  void initProduct(ProductModel product, CartController cart){
    _quantity=0;
    _inCartItems=0;
    _cart=cart;
    var exist = false;
    exist = _cart.existInCart(product);

    if(exist){
      _inCartItems=_cart.getQuantity(product);
    }
  }

  void addItem(ProductModel product){
   // if(quantity>0) {
      _cart.addItem(product, _quantity);
      _quantity = 0;
      _inCartItems=_cart.getQuantity(product);
      _cart.items.forEach((key, value) {
       // print("The id is "+value.id.toString()+" The quantity is "+value.quantity.toString());
      });

      // }else{
      //   Get.snackbar("Mahsulot soni", "Savatga allaqachon qo`shib bo`ldingiz!",
      //       colorText: Colors.white, backgroundColor: AppColors.mainColor
      //   );
      // }
    update();
  }

  int get totalItems{
    return _cart.totalItems;
  }

  List<CartModel> get getItems{
    return _cart.getItems;
  }
}